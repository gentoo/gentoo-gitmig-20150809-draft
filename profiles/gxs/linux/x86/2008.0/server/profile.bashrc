# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/gxs/linux/x86/2008.0/server/profile.bashrc,v 1.1 2008/05/17 11:42:55 pappy Exp $

if [[ "${EBUILD_PHASE}" == "setup" ]]
then
  echo
  einfo "**************************************"
  einfo "Gentoo Linux Extreme Security Solution"
  einfo "**************************************"
  echo
  einfo "This profile is in experimental state."
  einfo "It uses a special glibc with nptlonly,"
  einfo "does not support NLS and only supports"
  einfo "the CHOST i486-pc-linux-gnu currently."
  echo

  if [[ "x${CHOST}y" != "xi486-pc-linux-gnuy" ]]
  then
    eerror "your CHOST does not match for this profile:"
    eerror "your CHOST:${CHOST}"
    eerror "only CHOST=i486-pc-linux-gnu is supported at the moment"
    echo
    exit 1
  fi

  if [[ "x${I_KNOW_WHAT_I_AM_DOING_IS_EXPERIMENTAL_AND_UNTESTED}y" != "xgxslinuxy" ]]
  then
    eerror "you did not enable the magic environment var to use this profile"
    eerror "visit -freenode/#gxs-linux or -freenode/#gentoo-extreme-security"
    eerror "for support and to learn how to enable this linux server profile"
    echo
    exit 1
  fi
fi

