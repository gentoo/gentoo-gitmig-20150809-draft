# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-sork/horde-sork-0.ebuild,v 1.2 2004/08/15 16:38:52 stuart Exp $

inherit horde

DESCRIPTION="Sork is comprised of four Horde modules: accounts, forwards, passwd, vacation"
SRC_URI=""

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND="www-apps/horde-accounts
	www-apps/horde-forwards
	www-apps/horde-passwd
	www-apps/horde-vacation"

# this is just a meta package
pkg_setup() { :;}
src_install() { :;}
pkg_postinst() { :;}
