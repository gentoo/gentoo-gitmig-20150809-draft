package Apache2;

sub BEGIN {
  use Config;

  @inc = ( '/etc/perl',
	   $Config{sitearchexp},
	   $Config{sitelibexp},
	   $Config{vendorarchexp},
	   $Config{vendorlibexp},
	   $Config{archlibexp},
	   $Config{privlibexp},
	 );

  my @sfxs = split( / /, $Config{inc_version_list} );

  # this fails if we have numbers over 9. the goal is to get newer
  # versions earlier in the list.
  @sfxs = sort { $b cmp $a } @sfxs;

  my $site_pfx = $Config{sitelib_stem};
  my $vend_pfx = $Config{vendorlib_stem};
  for my $sfx ( @sfxs ) {
    push( @inc, "$site_pfx/$sfx", "$vend_pfx/$sfx" );
  }

  push( @inc,
	"/usr/local/lib/site_perl",
	"/usr/lib/apache2",
	"/usr/lib/apache2/lib/perl",
      );

  # no . here because it doesn't make sense for us

  # ok, now prepend Apache2 subdirectories of anything and take out
  # nonexistent directories.  a case could be made that leaving
  # nonexistent directories on here would be a good idea, but i'm
  # going to go with the "reduce clutter" goal for now.

  @INC = ();
  for my $cd ( @inc ) {
    next unless -d $cd;
    push( @INC, "$cd/Apache2" ) if -d "$cd/Apache2";
    push( @INC, $cd );
  }
}

1;
