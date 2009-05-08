# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/guilt/guilt-0.32.ebuild,v 1.1 2009/05/08 21:39:44 vapier Exp $

DESCRIPTION="A series of bash scripts which add a quilt-like interface to git"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/"
SRC_URI="mirror://kernel/linux/kernel/people/jsipek/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}-manpages-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="dev-util/git"
DEPEND="${RDEPEND}
	doc? ( app-text/asciidoc app-text/xmlto )"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/^PREFIX/s:=.*:=/usr:' \
		-e "/^htmldir/s:=.*:=/usr/share/doc/${PF}/html:" \
		-e "/^VERSION/s:=.*:=${PV}:" \
		Makefile */Makefile || die
}

src_compile() {
	if use doc ; then
		emake -C Documentation html || die
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die

	dodoc Documentation/{Contributing,Features,HOWTO,Requirements}
	doman Documentation/*.[0-9] || die

	if use doc ; then
		dodir "/usr/share/doc/${PF}/html"
		emake -C Documentation install-html DESTDIR="${D}" || die
	fi
}
