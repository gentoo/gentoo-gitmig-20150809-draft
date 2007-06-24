# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urw-fonts/urw-fonts-2.1-r2.ebuild,v 1.11 2007/06/24 19:11:13 drac Exp $

inherit eutils rpm font

DESCRIPTION="free good quality fonts gpl'd by URW++"
HOMEPAGE="http://www.urwpp.de/"
SRC_URI="ftp://fr2.rpmfind.net/linux/fedora/core/development/SRPMS/${P}-7.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

#DEPEND="app-arch/rpm2targz"
#DEPEND comes from rpm.eclass

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="afm pfb"
DOCS="ChangeLog README* TODO"

src_install () {

	font_src_install

	# don't touch our fonts.conf
	rm -fr ${D}/etc

}
