# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-sork/horde-sork-0.ebuild,v 1.3 2004/11/08 16:42:38 vapier Exp $

inherit horde

DESCRIPTION="Sork is comprised of four Horde modules: accounts, forwards, passwd, vacation"
SRC_URI=""

KEYWORDS="alpha amd64 hppa ppc sparc x86"

DEPEND=""
RDEPEND="www-apps/horde-accounts
	www-apps/horde-forwards
	www-apps/horde-passwd
	www-apps/horde-vacation"

S=${WORKDIR}

# this is just a meta package
pkg_setup() { :;}
src_install() { :;}
pkg_postinst() { :;}
