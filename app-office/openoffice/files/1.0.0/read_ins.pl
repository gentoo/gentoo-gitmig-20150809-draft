#!/usr/bin/perl
#
# Author: Preston A. Elder <prez@goth.net>
#
# Modified: Martin Schlemmer <azarah@gentoo.org>
#
#   20 Apr 2002: Change from STANDALONE to NETWORK.  Also do not create
#                the "InstLanguages" entry in the "Installation" section.
#                Fixed a stray "Styles" entry in the "Installation" section.
#                Updated to add " Installed\t = YES" to appropriate "Module"
#                sections.  Added output to first remove stale config files.
#                Modify to support $RUNARGS, as we dont want one script to
#                do all the work.
#
#   21 Apr 2002: Make use of NetDir for getting a value for $dir.
#
#                NOTE: as I dont know any perl to start with, things may not
#                      be done by the book ... feel free to fix .. =)

use strict;

my ($prefix) = $ENV{PREFIX};
my ($instdir) = $ENV{INSTDIR};
my ($destdir) = $ENV{DESTDIR};
my ($regcomp) = $ENV{REGCOMP};
my ($runargs) = $ENV{RUNARGS};

if (!length($runargs))
{
	$runargs = "install register createdb";
}

die if (!length($instdir) || !length($destdir) || !length($regcomp));

my ($finaldestdir) = $destdir;
$finaldestdir =~ s/^$prefix//;
$finaldestdir = "/" . $finaldestdir if ($finaldestdir !~ /^\//);

my (%directories, %packages, %files, %shortcuts, @dblines);
my ($tmp, %useddirs, %profiles, %profileitems, @components);

my ($directory, $parent, $hostname, $component);
my ($file, $filename, $package, $dir, $perms);
my ($installation, $product, $version, $language);
my ($shortcut, $scname, $fileid, $scdir, $dontdelete);
my ($profile, $p_name, $p_dir, $profileitem);
my ($pi_profile, $pi_sect, $pi_key, $pi_value);

$directories{PREDEFINED_PROGDIR} = [ "", $destdir ];
$directories{PREDEFINED_CONFIGDIR} = [ "", $ENV{HOME} ];

open(FH, "$instdir/setup.ins");
while (<FH>)
{
	chomp;

	if (/^End/)
    {
		if (length($directory) && length($parent) && length($hostname))
		{
			$hostname =~ s/\%PRODUCTNAME/$product/;
			$hostname =~ s/\%PRODUCTVERSION/$version/;
			$directories{$directory} = [ $parent, $hostname, $dontdelete ];
		}
		$dontdelete = 0;
		$directory = $parent = $hostname = "";

		if (length($file))
		{
			if (length($filename))
			{
				$files{$file} = [ $filename, $dir ];
				push(@components, $filename) if ($component);
			}
			if (length($package) && length($dir) && length($perms))
			{
				$packages{$package} = [ $dir, $perms ];
			}
		}
		$component = 0;
		$file = $filename = $package = $dir = $perms = "";

		if (length($installation))
		{
			if (length($product) && length($version))
			{
				push(@dblines, "\tDefaultDestPath = \"" . $product . $version . "\";");
			}
			push(@dblines, "\tDestPath = \"" . $finaldestdir . "\";");
			push(@dblines, "\tSourcePath = \"" . $instdir . "\";");
			push(@dblines, "\tMode = NETWORK;");
			push(@dblines, "\tInstallFromNet = NO;");
		}
		$installation = $language = "";

		if (length($shortcut) && length($scname) && length($fileid) && length($scdir))
		{
			$shortcuts{$shortcut} = [ $scname, $fileid, $scdir ];
		}
		$shortcut = $scname = $fileid = $scdir = "";

		if (length($profile) && length($p_name) && length($p_dir))
		{
			$profiles{$profile} = [ $p_name, $p_dir ];
		}
		$profile = $p_name = $p_dir = "";

		if (length($profileitem) && length($pi_profile) && length($pi_sect) && length($pi_key))
		{
			$profileitems{$pi_profile}->{$pi_sect}->{$pi_key} = $pi_value;
		}
		$profileitem = $pi_profile = $pi_sect = $pi_key = $pi_value = "";
	}
	elsif (/^Installation\s+(\S+)/)
	{
		$installation = $1;
	}
	elsif (/^Directory\s+(\S+)/)
	{
		$directory = $1;
	}
	elsif (/^File\s+(\S+)/)
	{
		$file = $1;
	}
	elsif (/^Shortcut\s+(\S+)/)
	{
		$shortcut = $1;
	}
	elsif (/^Profile\s+(\S+)/)
	{
		$profile = $1;
	}
	elsif (/^ProfileItem\s+(\S+)/)
	{
		$profileitem = $1;
	}
	elsif (length($installation))
	{
		if (/^\s*DefaultDestPath\s*=/)
		{
			next;
		}
		if (/^\s*ProductName\s*=\s*\"([^;]+)\";/)
		{
			$product = $1;
		}
		elsif (/^\s*ProductVersion\s*=\s*\"([^"]+)\";/)
		{
			$version = $1;
		}
		elsif (/^\s*DefaultLanguage\s*=\s*\"([^"]+)\";/)
		{
			$language = $1;
		}
	}
	elsif (length($directory))
	{
		if (/^\s*ParentID\s*=\s*([^;]+);/)
		{
			$parent = $1;
		}
		elsif (/^\s*HostName\s*=\s*\"([^"]+)\";/)
		{
			$hostname = $1;
		}
		elsif (/^\s*Styles\s*=\s*\(.*DONT_DELETE.*\);/)
		{
			$dontdelete = 1;
		}
	}
	elsif (length($file))
	{
		if (/^\s*Name\s*=\s*\"([^"]+)\";/)
		{
			$filename = $1;
		}
		elsif (/^\s*PackedName\s*=\s*\"([^"]+)\";/)
		{
			$package = $1;
		}
		# Only use Dir if not $dir is not set, as otherwise
		# $dir will contain a valid NetDir.
		elsif (/^\s*Dir\s*=\s*([^;]+);/)
		{
			if (!length($dir))
			{
				$dir = $1;
			}
		}
		elsif (/^\s*NetDir\s*=\s*([^;]+);/)
		{
			$dir = $1;
		}
		elsif (/^\s*UnixRights\s*=\s*([^;]+);/)
		{
			$perms = $1;
		}
		elsif (/^\s*Styles\s*=\s*\(.*UNO_COMPONENT.*\);/)
		{
			$component = 1;
		}
	}
	elsif (length($shortcut))
	{
		if (/^\s*Name\s*=\s*\"([^"]+)\";/)
		{
			$scname = $1;
		}
		elsif (/^\s*FileID\s*=\s*([^;]+);/)
		{
			$fileid = $1;
		}
		elsif (/^\s*Dir\s*=\s*([^;]+);/)
		{
			$scdir = $1;
		}
	}
	elsif (length($profile))
	{
		if (/^\s*Name\s*=\s*\"([^"]+)\";/)
		{
			$p_name = $1;
		}
		elsif (/^\s*Dir\s*=\s*([^;]+);/)
		{
			$p_dir = $1;
		}
	}
	elsif (length($profileitem))
	{
		if (/^\s*ProfileID\s*=\s*([^;]+);/)
		{
			$pi_profile = $1;
		}
		elsif (/^\s*Section\s*=\s*\"([^"]+)\";/)
		{
			$pi_sect = $1;
		}
		elsif (/^\s*Key\s*=\s*\"([^"]+)\";/)
		{
			$pi_key = $1;
		}
		elsif (/^\s*Value\s*=\s*\"([^"]+)\";/)
		{
			$pi_value = $1;
		}
	}

	my ($line) = $_;
	$line =~ s/[']/'"'"'/g;
	chop($line);

	push(@dblines, $line);
}
close(FH);

sub getFilePath
{
	my ($rv);
	my ($lookfor) = shift;

	if (defined($directories{$lookfor}))
	{
		if (defined($directories{@{$directories{$lookfor}}[0]}))
		{
			$rv = getFilePath(@{$directories{$lookfor}}[0]);
		}
		$rv .= "/" if (length($rv));
		$rv .= @{$directories{$lookfor}}[1];
	}
	return $rv;
}

foreach $tmp (sort keys %packages)
{
	my ($dir) = getFilePath(@{$packages{$tmp}}[0]);
	$useddirs{$dir} = ".";
}

foreach $tmp (sort keys %directories)
{
	if (@{$directories{$tmp}}[2])
	{
	    my ($dir) = getFilePath($tmp);
	    $useddirs{$dir} = ".";
	}
}

print "#!/bin/sh\n";

if ($runargs =~ /install/)
{
	print "mkdir -p \"$destdir\"\n";
	print "chmod 755 \"$destdir\"\n";

	foreach $tmp (sort keys %useddirs)
	{
		print "mkdir -p \"$tmp\"\n";
		print "chmod 755 \"$tmp\"\n";
	}

	print "mkdir /tmp/inst$$\n";
	print "cd /tmp/inst$$\n";

	foreach $tmp (sort keys %packages)
	{
		print "rm -f *\n";
		print "unzip -o \"$instdir/$tmp\"\n";
		print "chmod $packages{$tmp}[1] *\n";
		print "mv * \"" . getFilePath($packages{$tmp}[0]) . "\"\n";
	}

	print "cd \"$destdir\"\n";
	print "rm -rf /tmp/inst$$\n";

	foreach $tmp (sort keys %shortcuts)
	{
		if (defined($files{@{$shortcuts{$tmp}}[1]}) &&
		defined($directories{@{$shortcuts{$tmp}}[2]}))
		{
			my ($newdir) = getFilePath($files{$shortcuts{$tmp}[1]}[1]);
			$newdir =~ s/^$prefix//;
			$newdir = "/" . $newdir if ($newdir !~ /^\//);
			print "ln -sf \"$newdir/$files{$shortcuts{$tmp}[1]}[0]\" \"" .
			getFilePath($shortcuts{$tmp}[2]) . "/$shortcuts{$tmp}[0]\"\n";
		}
	}
}

if ($runargs =~ /createdb/)
{
	foreach $tmp (sort keys %profiles)
	{
		if (defined($directories{@{$profiles{$tmp}}[1]}))
		{
			my ($dir) = getFilePath($profiles{$tmp}[1]);
			my ($sect);
			foreach $sect (sort keys %{$profileitems{$tmp}})
			{
				# First remove any stale config files
				my ($cfgfile) = $profiles{$tmp}[0];
				if ($cfgfile !~ /sversionrc/)
				{
					print "rm -f \"$dir/$profiles{$tmp}[0]\"\n";
				}
				print "echo '[" . $sect . "]' >>\"$dir/$profiles{$tmp}[0]\"\n";
				my ($key);
				foreach $key (sort keys %{$profileitems{$tmp}->{$sect}})
				{
					my ($key2) = $key;
					$key2 =~ s/\%PRODUCTNAME/$product/;
					$key2 =~ s/\%PRODUCTVERSION/$version/;
					my ($value) = $profileitems{$tmp}->{$sect}->{$key};
					$value =~ s,<installmode>,NETWORK,;
					$value =~ s/<productkey>/$product $version/;
					$value =~ s,<workpath_url>,file://$finaldestdir,;
					print "echo '$key2=$value' >>\"$dir/$profiles{$tmp}[0]\"\n";
				}
				print "echo '' >>\"$dir/$profiles{$tmp}[0]\"\n";
			}
		}
	}
}

if ($runargs =~ /register/)
{
	print "LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:$destdir/program; export LD_LIBRARY_PATH\n";
	foreach $tmp (sort @components)
	{
		print "\"$regcomp\" -register -c \"$destdir/program/$tmp\" -r \"$destdir/program/applicat.rdb\"\n";
	}
}

if ($runargs =~ /install/)
{
	print "cp \"$instdir\"/LICENSE* \"$destdir\"\n";
	print "cp \"$instdir\"/README* \"$destdir\"\n";
}

if ($runargs =~ /createdb/)
{
	print "rm -f \"$destdir/program/instdb.ins\"\n";

	my ($ismod) = "0";
	my ($isinst) = "0";
	my ($modname) = "foo";
	foreach $tmp (@dblines)
	{
		# NETWORK installation
		$tmp =~ s,<installmode>,NETWORK,;
	
		# Are we in the "Installation" section?
		if ($tmp =~ /^Installation/)
		{
			$isinst = "1";
		}
		elsif ($tmp =~ /^End/)
		{
			$isinst = "0";
		}
	
		# Do not print a "Styles" line for the "Installation" section
		if (!(($isinst =~ "1") and ($tmp =~ /Styles/)))
		{
			print "echo '$tmp' >>\"$destdir/program/instdb.ins\"\n";
		}
	
		# Are we in a "Module" section?
		if ($tmp =~ /^Module/)
		{
			$ismod = "1";
			$modname = $tmp;
		}
		elsif ($tmp =~ /^End/)
		{
			$ismod = "0";
		}
		# All modules are installed
		if (($ismod =~ "1") and ($tmp =~ /Default/))
		{
			print "echo '\tInstalled\t = YES;' >>\"$destdir/program/instdb.ins\"\n";
		}
		# gid_Module_Root should also be "installed"
		elsif (($ismod =~ "1") and ($modname =~ /gid_Module_Root/) and ($tmp =~ /Description/))
		{
			print "echo '\tInstalled\t = YES;' >>\"$destdir/program/instdb.ins\"\n";
		}
	}
}

