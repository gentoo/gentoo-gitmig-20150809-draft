# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/filer/filer-0.0.8.ebuild,v 1.2 2005/05/25 13:49:12 mcummings Exp $

DESCRIPTION="Small file-manager written in perl"
HOMEPAGE="http://blog.perldude.de/projects/filer/"
SRC_URI="http://perldude.de/projects/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/gtk2-perl
	dev-perl/gtk2-gladexml
	dev-perl/File-MimeInfo
	perl-core/File-Temp
	dev-perl/TimeDate
	dev-perl/Stat-lsMode"
DEPEND="sys-apps/findutils"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	find ${S} -type d -name .svn | xargs rm -rf
}

src_compile() {
	true
}

src_install() {
	newbin filer.pl filer || die "newbin failed"
	insinto /usr/lib/filer
	doins -r Filer icons lib.pl || die "doins failed"
	dodoc AUTHORS || die "dodoc failed"
}
