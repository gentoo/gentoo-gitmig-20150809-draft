#!/usr/bin/perl
#

use strict;

my ($prefix) = $ENV{PREFIX};
my ($instdir) = $ENV{INSTDIR};
my ($destdir) = $ENV{DESTDIR};
my ($regcomp) = $ENV{REGCOMP};

die if (!length($instdir) || !length($destdir) || !length($regcomp));

my ($finaldestdir) = $destdir;
$finaldestdir =~ s/^$prefix//;
$finaldestdir = "/" . $finaldestdir if ($finaldestdir !~ /^\//);

my (%directories, %packages, %files, %shortcuts, @dblines);
my ($tmp, %useddirs, %profiles, %profileitems, @components);

my ($directory, $parent, $hostname, $component);
my ($file, $filename, $package, $dir, $perms);
my ($installation, $product, $version, $language);
my ($shortcut, $scname, $fileid, $scdir);
my ($profile, $p_name, $p_dir, $profileitem);
my ($pi_profile, $pi_sect, $pi_key, $pi_value);

$directories{PREDEFINED_PROGDIR} = [ "", $destdir ];
$directories{PREDEFINED_CONFIGDIR} = [ "", $ENV{HOME} ];

open(FH, "$instdir/setup.ins");
while (<FH>) {
    chomp;

    if (/^End/)
    {
	if (length($directory) && length($parent) && length($hostname))
	{
	    $directories{$directory} = [ $parent, $hostname ];
	}
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
	    if (length($language))
	    {
		push(@dblines, "\tInstLanguages = \"" . $language . ":1:1\";");
	    }
	    push(@dblines, "\tDestPath = \"" . $finaldestdir . "\";");
	    push(@dblines, "\tSourcePath = \"" . $instdir . "\";");
	    push(@dblines, "\tMode = NETWORK;");
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
	elsif (/^\s*Dir\s*=\s*([^;]+);/)
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
    my ($dir) = getFilePath($packages{$tmp}[0]);
    $useddirs{$dir} = ".";
}

print "#!/bin/sh\n";

print "mkdir -p $destdir\n";
print "chmod 755 $destdir\n";

foreach $tmp (sort keys %useddirs)
{
    print "mkdir -p $tmp\n";
    print "chmod 755 $tmp\n";
}

print "mkdir /tmp/inst$$\n";
print "cd /tmp/inst$$\n";

foreach $tmp (sort keys %packages)
{
    print "rm -f *\n";
    print "unzip $instdir/$tmp\n";
    print "chmod $packages{$tmp}[1] *\n";
    print "mv * " . getFilePath($packages{$tmp}[0]) . "\n";
}

print "cd $destdir\n";
print "rm -rf /tmp/inst$$\n";

foreach $tmp (sort keys %shortcuts)
{
    if (defined($files{@{$shortcuts{$tmp}}[1]}) &&
	defined($directories{@{$shortcuts{$tmp}}[2]}))
    {
	my ($newdir) = getFilePath($files{$shortcuts{$tmp}[1]}[1]);
	$newdir =~ s/^$prefix//;
	$newdir = "/" . $newdir if ($newdir !~ /^\//);
	print "ln -sf $newdir/$files{$shortcuts{$tmp}[1]}[0] " .
		getFilePath($shortcuts{$tmp}[2]) . "/$shortcuts{$tmp}[0]\n";
    }
}

foreach $tmp (sort keys %profiles)
{
    if (defined($directories{@{$profiles{$tmp}}[1]}))
    {
	my ($dir) = getFilePath($profiles{$tmp}[1]);
	my ($sect);
	foreach $sect (sort keys %{$profileitems{$tmp}})
	{
	    print "echo '[" . $sect . "]' >>$dir/$profiles{$tmp}[0]\n";
	    my ($key);
	    foreach $key (sort keys %{$profileitems{$tmp}->{$sect}})
	    {
		my ($key2) = $key;
		$key2 =~ s/\%PRODUCTNAME/$product/;
		$key2 =~ s/\%PRODUCTVERSION/$version/;
		my ($value) = $profileitems{$tmp}->{$sect}->{$key};
		$value =~ s/<installmode>/NETWORK/;
		$value =~ s/<productkey>/$product $version/;
		$value =~ s,<workpath_url>,file://$finaldestdir,;
		print "echo '$key2 = $value' >>$dir/$profiles{$tmp}[0]\n";
	    }
	    print "echo '' >>$dir/$profiles{$tmp}[0]\n";
	}
    }
}

print "LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:$destdir/program; export LD_LIBRARY_PATH\n";
foreach $tmp (sort @components)
{
    print "$regcomp -register -c $destdir/program/$tmp -r $destdir/program/applicat.rdb\n";
}

print "cp $instdir/LICENSE* $destdir\n";
print "cp $instdir/README* $destdir\n";

foreach $tmp (@dblines)
{
    print "echo '$tmp' >>$destdir/program/instdb.ins\n";
}
