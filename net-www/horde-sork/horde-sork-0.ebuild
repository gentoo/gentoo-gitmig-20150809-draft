# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-sork/horde-sork-0.ebuild,v 1.1 2004/01/27 01:15:03 vapier Exp $

inherit horde

DESCRIPTION="Sork is comprised of four Horde modules: accounts, forwards, passwd, vacation"
SRC_URI=""

KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND="net-www/horde-accounts
	net-www/horde-forwards
	net-www/horde-passwd
	net-www/horde-vacation"

# this is just a meta package
pkg_setup() { :;}
src_install() { :;}
pkg_postinst() { :;}
