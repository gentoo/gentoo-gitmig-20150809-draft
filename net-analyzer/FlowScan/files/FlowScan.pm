#  FlowScan.pm - a base class for scanning and reporting on flows
#  Copyright (C) 1998-2001  Dave Plonka
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# $Id: FlowScan.pm,v 1.1 2005/06/22 14:56:17 strerror Exp $
# Dave Plonka <plonka@doit.wisc.edu>

use strict;
use RRDs;

package FlowScan;

require 5;
require Exporter;

@FlowScan::ISA=qw(Exporter);
@FlowScan::EXPORT_OK=qw(ip2name);
# convert the RCS revision to a reasonable Exporter VERSION:
'$Revision: 1.1 $' =~ m/(\d+)\.(\d+)/ && (( $FlowScan::VERSION ) = sprintf("%d.%03d", $1, $2));

=head1 NAME

FlowScan -

=head1 SYNOPSIS

   $ flowscan FlowScanDerivedClass [...]

=head1 DESCRIPTION

This package implements a base-class solely for use with the flowscan utility.
Once you author derived classes, those class names are passed as arguments.

The following methods and subroutines are defined:

=over 4

=cut

=item new

The B<new> method constructs and returns a B<FlowScan> object.
You must define a report method in your derived class.

=cut

sub new {
   die "you must define a new method in your derived class!\n"
}

=item wanted

You must define a report method in your derived class.

=cut

sub wanted {
   die "you must define a wanted method in your derived class!\n"
}

=item perfile

You may define a perfile method in your derived class.
To maintain the functionality of the base-class method, do something like this:

   sub perfile {
      my $self = shift;
      $self->SUPER::perfile(@_);
      # ...
   }

=cut

sub perfile {
   my $self = shift;
   my $file = shift;
   $self->{filetime} = file2time_t($file)
}

sub file2time_t {
   my $file = shift;
   if ($file =~
    m/(\d\d\d\d)-?(\d\d)-?(\d\d)[_.](\d\d):?(\d\d):?(\d\d)([+-])(\d\d)(\d\d)/) {
      # The file name contains an "hours east of GMT" component
      my(@tm) = ($6, $5, $4, $3, $2-1, $1-1900, 0, 0, -1);
      my($tm_sec, $tm_min, $tm_hour, $tm_mday, $tm_mon, $tm_year,
	 $tm_wday, $tm_yday, $tm_isdst) = (0 .. 8); # from "man perlfunc"
      if ('+' eq $7) { # subtract hours and minutes to get UTC
	 $tm[$tm_min] -= 60*$8+$9
      } else { # add hours and minutes to get UTC
	 $tm[$tm_min] += 60*$8+$9
      }
      mutt_normalize_time(@tm);
      return mutt_mktime(@tm, -1, 0)
   } elsif ($file =~ m/(\d\d\d\d)-?(\d\d)-?(\d\d)[_.](\d\d):?(\d\d):?(\d\d)$/) {
      # The file name contains just the plain old localtime
      return mutt_mktime($6, $5, $4, $3, $2-1, $1-1900, 0, 0, -1, 1)
   } else {
      return -1
   }
   # NOTREACHED
}

sub mkdirs_as_necessary {
   my $n = 0;
   foreach my $file (@_) {
      my $pos = 0;
      my $len;
      while (-1 < ($len = index($file, '/', $pos))) {
	 $len++;
         my $dir = substr($file, 0, $len);
         $pos = $len;
	 next if -d $dir;
         if (!mkdir($dir, 0777)) {
            warn "mkdir \"$dir\": $!\n";
            return 0
         }
         $n++;
      }
   }
   return $n # no. of successful mkdir(2)s
}

sub createGeneralRRD {
   my $self = shift;
   die unless ref($self);
   my $file = shift;

   die unless @_; # DS types and names are required

   my $time_t = $self->{filetime};

   my $startwhen = $time_t - 300;
   my($name, $type, @DS);
   while (($type = shift(@_)) &&
	  ($name = shift(@_))) {
      push(@DS, "DS:${name}:${type}:400:U:U")
   }
   RRDs::create($file,
      '--start', $startwhen,
      '--step', 300,
      @DS,
      qw(
         RRA:AVERAGE:0:1:600
         RRA:AVERAGE:0:6:600
         RRA:AVERAGE:0:24:600
         RRA:AVERAGE:0:288:1827
         RRA:MAX:0:24:600
         RRA:MAX:0:288:1827
	 )
      );
   my $err=RRDs::error;
   warn "ERROR creating $file: $err\n" if $err;
}

=item report

You must define a report method in your derived class.

=cut

sub report {
   die "you must define a report method in your derived class!\n"
}

=head1 BUGS

=head1 AUTHOR

Dave Plonka <plonka@doit.wisc.edu>

Copyright (C) 1998-2001  Dave Plonka.
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

=head1 VERSION

The version number is the module file RCS revision number (B<$Revision: 1.1 $>)
with the minor number printed right justified with leading zeroes to 3
decimal places.  For instance, RCS revision 1.1 would yield a package version
number of 1.001.

This is so that revision 1.10 (which is version 1.010), for example, will
test greater than revision 1.2 (which is version 1.002) when you want to
B<require> a minimum version of this module.

=cut

# The following routines are my rewrites from mutt's "date.c", which is:
# 
#  Copyright (C) 1996-2000 Michael R. Elkins <me@cs.hmc.edu>
# 
#      This program is free software; you can redistribute it and/or modify
#      it under the terms of the GNU General Public License as published by
#      the Free Software Foundation; either version 2 of the License, or
#      (at your option) any later version.
# 
#      This program is distributed in the hope that it will be useful,
#      but WITHOUT ANY WARRANTY; without even the implied warranty of
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#      GNU General Public License for more details.
# 
#      You should have received a copy of the GNU General Public License
#      along with this program; if not, write to the Free Software
#      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# 

# returns the seconds east of UTC given `g' and its corresponding gmtime()
# representation
sub compute_tz {
   my($g, @utc) = @_;
   my @lt = localtime($g);
   my $t;
   my $yday;

   my($tm_hour, $tm_min, $tm_yday) = (2, 1, 7); # from "man perlfunc"
   $t = ((($lt[$tm_hour] - $utc[$tm_hour]) * 60) +
         ($lt[$tm_min] - $utc[$tm_min])) * 60;

   if ($yday = ($lt[$tm_yday] - $utc[$tm_yday])) {
      # This code is optimized to negative timezones (West of Greenwich)
      if ($yday == -1 ||   # UTC passed midnight before localtime
          $yday > 1) {     # UTC passed new year before localtime
         $t -= 24 * 60 * 60
      }
      else {
         $t += 24 * 60 * 60
      }
   }

  return $t
}

# converts struct tm to time_t, but does not take the local timezone into
# account unless ``local'' is nonzero
sub mutt_mktime {
  my $local = pop(@_);
  my(@t) = @_;
  my $g;

  my @AccumDaysPerMonth = (
    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
  );

  my($tm_sec, $tm_min, $tm_hour, $tm_mday, $tm_mon,
     $tm_year, $tm_wday, $tm_yday, $tm_isdst) = (0 .. 8); # from "man perlfunc"
  # Compute the number of days since January 1 in the same year
  $g = $AccumDaysPerMonth[$t[$tm_mon] % 12];

  # The leap years are 1972 and every 4. year until 2096,
  # but this algoritm will fail after year 2099
  $g += $t[$tm_mday];
  if (($t[$tm_year] % 4) || $t[$tm_mon] < 2) {
    $g--
  }
  $t[$tm_yday] = $g;

  # Compute the number of days since January 1, 1970
  $g += ($t[$tm_year] - 70) * 365;
  $g += int(($t[$tm_year] - 69) / 4);

  # Compute the number of hours
  $g *= 24;
  $g += $t[$tm_hour];

  # Compute the number of minutes
  $g *= 60;
  $g += $t[$tm_min];

  # Compute the number of seconds
  $g *= 60;
  $g += $t[$tm_sec];

  if ($local) {
    $g -= compute_tz($g, @t);
  }

  return($g)
}

sub mutt_normalize_time {
  my @DaysPerMonth = (
    31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
  );

  my($tm_sec, $tm_min, $tm_hour, $tm_mday, $tm_mon,
     $tm_year, $tm_wday, $tm_yday, $tm_isdst) = (0 .. 8); # from "man perlfunc"
  while ($_[$tm_sec] < 0)
  {
    $_[$tm_sec] += 60;
    $_[$tm_min]--
  }
  while ($_[$tm_min] < 0)
  {
    $_[$tm_min] += 60;
    $_[$tm_hour]--
  }
  while ($_[$tm_hour] < 0)
  {
    $_[$tm_hour] += 24;
    $_[$tm_mday]--
  }
  while ($_[$tm_mon] < 0)
  {
    $_[$tm_mon] += 12;
    $_[$tm_year]--
  }
  while ($_[$tm_mday] < 0)
  {
    if ($_[$tm_mon]) {
      $_[$tm_mon]--
    } else {
      $_[$tm_mon] = 11;
      $_[$tm_year]--
    }
    $_[$tm_mday] += $DaysPerMonth[$_[$tm_mon]]
  }
}

1

