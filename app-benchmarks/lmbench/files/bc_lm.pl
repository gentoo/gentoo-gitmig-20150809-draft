#!/usr/bin/perl -w
######################################################################
# lmbench Script - bc_lm.pl
#
#Use: Beaver Challenge
#
#Author:  Kaitlin Rupert, Open Source Lab - Oregon State University
#
#About:
#       This script is a wrapper for lmbench (created by Larry McVoy  
#       and Carl Staelin).
#
#       This script provides an easy means for participants of the
#       Beaver Challenge to benchmark their distributions in a manner
#       that is the same as other participating teams.
#
#Requirements:
#       Be sure that the CONFIG file is in the directory you unpacked
#       the lmbench tar. i.e.: If you unpacked the tar file to your
#       home directory, place the CONFIG file in your home directory.
#
#        Be sure you have the proper header files installed for your
#        distro (such as libc6-dev, etc). 
######################################################################
                                                                               
use strict;
                                                                               
print "\n\n\n***Starting the perfomance analysis portion of Beaver \
Challenge. ***This will be done using lmbench.\n\n";

my $distro = " ";
while ($distro eq " ")
{
  print "  Please enter the distribution this test is running on.  If you \
  running on Ark Linux, for example, you would enter ark.  [ark]: ";

  $distro = <STDIN>;
  chomp($distro);

  print "\n\nYou entered: $distro.  Is this correct? [y]";

  my $response = <STDIN>;
  chomp($response);

  if (($response ne "y") && (length($response) != 0))
  {
     $distro = " ";
  }

 print "\n\n";
}

$distro =~ s/[ \t\r\n]+//g;

my (@files);
opendir (DIR, '.') or die "Can't open current dir: $!\n";
@files = grep (!/^\.\.?$/, readdir (DIR));
closedir (DIR);

my $file;
my @dir;
foreach $file (@files)
{
   if (substr("$file", 0, 7) eq "lmbench")
   {
      push (@dir, "$file");
   }
}

my $dir;
foreach $file (@dir)
{
   if (chdir "$file")
   {
      $dir = $file; 
   }
}

if (!(chdir "src"))
{
   print "$dir - incorrect path to lmbench.  Please specificy full path\n";

   $dir = " ";
   while ($dir eq " ")
   {
      $dir = <STDIN>;
      chomp($dir);

      print "\n\nYou entered: $dir.  Is this correct? [y]";

      my $response = <STDIN>;
      chomp($response);

      if (($response ne "y") && (length($response) != 0))
      {
         $dir = " ";
      }
   }

   print "\n\n";

   chdir "$dir/src" or die "$dir not path to lmbench.  Please rerun script.\n";
}

`../scripts/build all`;
`../scripts/target`;
my $os = `../scripts/os`;
chomp($os);
`../scripts/compiler`;
`../scripts/info`;
`../scripts/version`;
my $config = `../scripts/config`;
chomp($config);

open (IN, "../../CONFIG") or die $!;
open (OUT, ">../bin/$os/$config") or die $!;
while (<IN> ) 
{
   if (/OS/) 
   {
      /^(\s*)/;
      print OUT $1,"OS=\"$os\"\n";
   }

   else
   {
      print OUT;
   }
}
close (OUT);
close (IN);


`../scripts/results`;

chdir ".." or die $!;

system("tar -cf ../lmbench_results_$distro.tar results/$os");

print "\n\n\n***lmbench portion complete.  The results have been archived in\
  ../lmbench_results_$distro.tar\n";
