# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-en_GB/kde-i18n-en_GB-3.0.1.ebuild,v 1.1 2002/05/16 18:27:14 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-i18n

# override the kde-i18n.eclass function, which adds a patch needed
# for all kde-i18n ebuilds but this
src_unpack() {
	unpack ${A//kde-i18n-gentoo.patch}
}
