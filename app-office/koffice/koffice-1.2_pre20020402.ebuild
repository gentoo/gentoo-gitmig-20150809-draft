# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2_pre20020402.ebuild,v 1.1 2002/04/02 18:44:38 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.2.2

S=${WORKDIR}/${PN}
DESCRIPTION="KDE Office Set"
HOMEPAGE="http://www.koffice.org/"
SLOT="0"

SRC_URI="http://www.ibiblio.org/gentoo/distfiles/koffice-20020402.tar.bz2"

DEPEND="$DEPEND
	>=dev-lang/python-2.0-r5"
#	>=sys-devel/automake-1.4
#	>=sys-devel/autoconf-1.13"

