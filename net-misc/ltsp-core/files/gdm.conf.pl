#!/usr/bin/perl -w
#
# Version: 0.02 	last modify: 10/21/2001 jam
#
# Description:
#    Read data stream from <stdin> and modify some stuff and
#    write it to <stdout>. Here we use it only for the gdm.conf file.
#
#    Copyright (C) 2000 Stephan Lauffer <lauffer@ph-freiburg.de>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

use strict;

my ($section);
$section="";

# Read from <stdin>
#
while (<STDIN>) {
	
	# remove the newline character 
	#
	chomp;
	
	# Check if the line looks like the beginning of a new section.
	# These sections are included in the brackets like this: [xdmcp]
	#
	if (/\[(\w+)\]/) {
		
		# store the found section name in variable $section
		#
		$section = $1;
		
		# print this line to <stdout> and look for the next line
		#
		print ("$_\n");
		next;
	}
	
	# If we're in section "xdmcp", change the option-value pair
	# Enable=0 to Enable=1
	#
	if ("$section" eq "xdmcp") {
		if ($_ =~ s/Enable\s*=\s*0\s*/Enable=1/) {
			
			# now the work is done... to disable all further
			# test for s/Enable\... set the $sectin to anything
			# but "xdmcp"
			#
			$section="nothing more to grep for...";
		}
		elsif ($_ =~ s/Enable\s*=\s*false\s*/Enable=true/) {
			
			# now the work is done... to disable all further
			# test for s/Enable\... set the $sectin to anything
			# but "xdmcp"
			#
			$section="nothing more to grep for...";
		}
		# print this line to <stdout> and look for the next line
		#
		print ("$_\n");
		next;
	}

	# If we don't change the line, print the "original" to 
	# stdout.
	#
	print ("$_\n");
}
