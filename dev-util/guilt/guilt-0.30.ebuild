# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/guilt/guilt-0.30.ebuild,v 1.4 2009/05/08 21:39:17 vapier Exp $

DESCRIPTION="A series of bash scripts which add a quilt-like interface to git"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/"
SRC_URI="mirror://kernel/linux/kernel/people/jsipek/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}-manpages-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE="doc"

RDEPEND="dev-util/git"
DEPEND="${RDEPEND}
	doc? ( app-text/asciidoc
		app-text/xmlto )"

RESTRICT="test"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	unpack ${PN}-manpages-${PV}.tar.bz2

	sed	-e 's/`git-describe`'"/${PV}/" \
		-i Documentation/Makefile || die 'Sed failed'
}

src_compile() {
	if use doc; then
		cd Documentation
		emake html || die "Generating html docs failed"
	fi
}

src_install() {
	emake install PREFIX="${D}/usr" || die "Install failed"

	dodoc Documentation/{Contributing,Features,HOWTO,Requirements} || die "dodoc failed"
	doman man?/* || die "doman failed"

	if use doc; then
		cd Documentation
		dodir "/usr/share/doc/${PF}/html"
		emake install-html htmldir="${D}/usr/share/doc/${PF}/html" || die "Install doc failed"
	fi
}
