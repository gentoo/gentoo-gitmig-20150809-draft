# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.ogr>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-en_GB/kde-i18n-en_GB-3.0.ebuild,v 1.3 2002/04/28 01:42:58 seemant Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-i18n

# override the kde-i18n.eclass function, which adds a patch needed
# for all kde-i18n ebuilds but this
src_unpack() {
	unpack ${A//kde-i18n-gentoo.patch}
}
