# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdoc/kdoc-2.2.2-r1.ebuild,v 1.1 2002/01/09 19:13:23 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Documentation tools"

newdepend "sys-devel/perl"

src_install() {
    kde_src_install
    cd ${D}/${KDEDIR}
    mv man ${D}/usr
}