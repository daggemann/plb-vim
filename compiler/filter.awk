#!/bin/awk
BEGIN 	{ 
	is_heading = 1;
	heading_counter = 0;
	error_counter = 0;
	column_offset = 39;
	is_footer = 1;
	footer_counter = 0;
}
	{
		if ($1 ~ /PAGE/){
			next;
		}

		if ($0 ~ /^\s*$/){
			next;
		}
		# Build heading and extract compilation file
		while (is_heading == 1){
			heading_counter++;
			if ($0 ~ /COMMAND LINE WAS/){
				is_heading = 0;
				compilation_file = $5;
			}
			heading[heading_counter] = $0;
			next;
		}

		if ($1 ~ /[[:digit:]]/){
			if ($0 ~ /INCLUDE\s+[[:alpha:]]+/){
				include_length = length($3);
				include_letter = substr($3, 0, include_length - 1);
				include_files[include_letter] = $4;
				next;
			}
			else if ($2 !~ /[[:alpha:]]+/){
				include_letter = " ";	
			}
			error_line = substr($1, 0, length($1) - 1)
			next;
		}
		else if ($1 ~ /ERROR/){
			error_counter++;
			error_column[error_counter] = index($0, "*") - column_offset;
			getline;
			error_msg[error_counter] = $0;
			error_lines[error_counter] = error_line;
			if (include_letter ~ /[[:alpha:]]+/){
				error_file[error_counter] = include_files[include_letter];
			}
			else {
				error_file[error_counter] = compilation_file;		
			}
		}

		if ($1 ~ /Output/){
			while (is_footer == 1) {
				footer_counter++;
				footer[footer_counter] = $0;
				if (getline == 0){
					is_footer = 0;
				}
			}
		}
	}
END   	{
	for (line_number in heading){
		gsub(//,"",heading[line_number]);
		print heading[line_number];
	}
	for (error_number in error_msg){
		error = error_file[error_number]":"error_lines[error_number]":"error_column[error_number]":"error_msg[error_number];
		gsub(//, "", error);
		print error;
	}
	for (line_number in footer){
		gsub(//,"",footer[line_number]);
		print footer[line_number];
	}
}
