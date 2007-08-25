# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdlabelgen/cdlabelgen-3.6.0.ebuild,v 1.5 2007/08/25 16:29:31 beandog Exp $

inherit eutils

DESCRIPTION="CD cover, tray card and envelope generator"
HOMEPAGE="http://www.aczoom.com/tools/cdinsert"
SRC_URI="http://www.aczoom.com/pub/tools/${P}.tgz"
LICENSE="aczoom"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-create-MAN_DIR.diff
	sed -i \
		-e "/fix @where_is_the_template/d" \
			"${S}"/Makefile || die "sed failed."
}

src_install() {
	make \
		BASE_DIR="${D}"/usr \
		LIB_DIR="${D}"/usr/share/cdlabelgen \
		MAN_DIR="${D}"/usr/share/man \
		install || die "install problem"
	dodoc ChangeLog README INSTALL.WEB cdinsert.pl || die "dodoc failed."
	dohtml *.html || die "dohtml failed."
#	doman cdlabelgen.1 || die "doman failed."
}
