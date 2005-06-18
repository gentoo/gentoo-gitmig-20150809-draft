# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdlabelgen/cdlabelgen-3.5.0.ebuild,v 1.1 2005/06/18 19:39:33 tove Exp $

DESCRIPTION="CD cover, tray card and envelope generator"
HOMEPAGE="http://www.aczoom.com/tools/cdinsert"
SRC_URI="http://www.aczoom.com/pub/tools/${P}.tgz"
LICENSE="aczoom"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:^BASE_DIR   = /usr/local:BASE_DIR   = ${D}/usr:g" \
		-e "s:^LIB_DIR   = \$(BASE_DIR)/lib/cdlabelgen:LIB_DIR   = \$(BASE_DIR)/share/cdlabelgen:g" \
		-e "/\$(INSTALL) cdlabelgen.1 \$(MAN_DIR)\/man1/d" \
		-e "/fix @where_is_the_template/d" \
			${S}/Makefile || die "sed failed."
}

src_install() {
	emake  install || die "install problem"
	dodoc ChangeLog README INSTALL.WEB cdinsert.pl || die "dodoc failed."
	dohtml *.html || die "dohtml failed."
	doman cdlabelgen.1 || die "doman failed."
}
