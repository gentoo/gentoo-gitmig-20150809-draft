#!/usr/bin/perl -w
# pdftops.pl - wrapper script for xpdf's pdftops utility to act as a CUPS filter
# ==============================================================================
# 1.00 - 2004-10-05/Bl
#	Initial implementation
#
# Copyright: Helge Blischke / SRZ Berlin 2004
# This program is free seoftware and governed by the GNU Public License Version 2.
#
# Description:
# ------------
#	This program wraps the pdftops utility from the xpdf 3.00 (and higher) suite
#	to behave as a CUPS filter as a replacement for the original pdftops filter.
#
#	The main purpose of this approach is to keep the properties of a PDF to be
#	printed as undesturbed as possible, especially with respect to page size,
#	scaling, and positioning.
#
#	The pdftops utility reads a configuration file 'pdftops.conf' in the 
#	CUPS_SERVERROOT directory, which must exist but may be empty. The sample
#	configuration file accompanying this program sets the defaults which
#	seem plausible to me with respect to high end production printers.
#
#	To give the user highest possible flexibility, this program accepts and
#	evaluates a set of job attributes special to this filter, which are 
#	described below:
#	
#		pdf-pages=<f>,<l>
#				expands to the -f and -l options of pdftops
#				to select a page range to process. This is independent
#				of the page-ranges attribute and may significantly
#				increase throughput when printing page ranges.
#				Either of these numbers may be omitted.
#
#		pdf-paper=<name>
#		pdf-paper=<width>x<height>
#				<name> may be one of letter, legal , A4, A3, or match;
#				<width> and <height> are the paper width and height
#				in printers points (1/72 inch). This expands to
#				either the -paper or the -paperh and -paperw options
#				of pdftops
#
#		pdf-opw=<password>
#		pdf-upw=<password>
#				expand to the -opw and -upw options of pdftops,
#				respectively and permit printing of password
#				protected PDFs.
#
#		pdf-<option>	where <option> is one of
#				level1, level1sep, level2, level2sep, level3, level3sep,
#				opi, nocrop, expand, noshrink, nocenter.
#				See the pdftops manpage for a detailed description of
#				the respective options.
#
#	All other pdftops commandline options are refused.
#
#	When printing from STDIN, the program copies the input to a temporary file
#	in TMPDIR, which is deleted on exit.
#
#	The return code of the pdftops utility, if nonzero, is used as the exit code
#	of this program; error messages of the pdftops utility are only visible
#	if 'debug' is specified as LogLevel in cupsd.conf.

#
# Site specific parameters - modify as needed
# ------------------------------------------------------------------------------
$pdftops_path = "/usr/bin/pdftops";	# path to the xpdf utility
# ------------------------------------------------------------------------------

use File::Copy;

#
# Check the arguments
#
die ("ERROR: wrong number of arguments\n") if (scalar @ARGV < 5);

$jobid = $username = $title = $copies = undef;
$jobid = shift;					# Job ID
$username = shift;				# Job requesting user name
$title = shift;					# Job title
$copies = shift;				# Number of requested copies
$options = shift;				# Textual representation of job attributes
$pdffile = shift;				# Pathname of PDF file to process

# If we are reading from STDIN, we must copy the input to a temporary file
# as the PDF consumer needs a seekable input.

if (! defined $pdffile)
{
	my $tmpfile = $ENV{TMPDIR} . "pdfin.$$.tmp";
	open (TEMP, ">$tmpfile") || die ("ERROR: pdftops wrapper: $tmpfile: $!\n");
	if (! copy (STDIN, TEMP))
	{
		close (TEMP);
		unlink $tmpfile;
		die ("ERROR: pdftops wrapper: $tmpfile: $!\n");
	}
	close (TEMP);
	$pdffile = $tmpfile;
	$delete_input = 1;			# for deleting the temp file after converting
}

# 
# Check the options string for options to modify the bahaviour of the pdftops utility:
#
@optarr = split (/\s+/, $options);
$cmdopt = "-cfg " . $ENV{CUPS_SERVERROOT} . "/pdftops.conf";	# This cannot be changed
# The following are the (parameterless) command line options that may be used to change the 
# defaults defiend by pdftops.conf
$simple = 'level1|level1sep|level2|level2sep|level3|level3sep|opi|nocrop|expand|noshrink|nocenter';
foreach my $option (@optarr)
{
	if ($option =~ /^pdf-(.+)$/)
	{	# We assume this is an option to evaluate
		my $optkey = $1;		# possible pdftops option
		if ($optkey =~ /^pages=(\d*),(\d*)$/)
		{
			# We do this hack here to avoid clashes with the page-ranges atrribute
			# which is handled by the pstops filter. And we allow one of the numbers
			# to be omitted.
			my $first = $1;
			my $lastp = $2;
			$cmdopt .= " -f $1" if ($1);		# first page
			$cmdopt .= " -l $2" if ($2);		# last page
		}
		elsif ($optkey =~ /^paper=(letter|legal|A4|A3|match)$/)
		{
			$cmdopt .= " -paper $1";			# paper name
		}
		elsif ($optkey =~ /^paper=(\d+)x(\d+)$/)
		{
			$cmdopt .= " -paperw $1 -paperh $2";		# paper dimensions
		}
		elsif ($optkey =~ /^(o|u)pw=(\S+)$/)
		{
			$cmdopt .= " $1" . 'pw ' . $2;			# owner/user password
		}
		elsif ($optkey =~ /^($simple)$/)
		{
			$cmdopt .= ' -' . $1;				# allowed simple options
		}
		else
		{
			warn ("ERROR: pdftops wrapper: illegal attribute \"pdf-$optkey\"\n");
		}
	}
	# All other attributes are processed elsewhere
}
#
# Complete the command
#
warn ("ERROR: pdftops-options: $cmdopt\n");
$rc = system ("$pdftops_path $cmdopt $pdffile -");
if ($rc)
{
	$ir = $rc & 127;
	$rc >>= 8;
	warn ("ERROR: pdftops_path exited with ", ($ir) ? "signal $ir, " : " exit code $rc", "\n");
	exit $rc;
}
unlink ($pdffile) if (defined $delete_input);		# Delete the temp file if any
exit 0;
