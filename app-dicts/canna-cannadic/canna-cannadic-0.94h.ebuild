# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/canna-cannadic/canna-cannadic-0.94h.ebuild,v 1.1 2003/05/17 19:27:13 nakano Exp $

MY_P="${P/canna-/}"

DESCRIPTION="Japanese kana-kanji conversion dictionary for Canna"
HOMEPAGE="http://cannadic.oucrc.org/"
SRC_URI="http://cannadic.oucrc.org/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND=">=canna-3.6_p3-r1"
S="${WORKDIR}/${MY_P}"

src_compile() {
	make maindic || die
}

src_install() {
	dodir /var/lib/canna/dic/canna/
	install -o bin -g bin -m 0664 gcanna.c[bl]d gcannaf.t \
		${D}/var/lib/canna/dic/canna/
	insinto /var/lib/canna/dic/dics.d/ ;\
		doins ${FILESDIR}/01cannadic.dics.dir
	dodoc COPYING README
}

pkg_postinst() {
	if [ -x /usr/sbin/update-canna-dics_dir ]; then
		einfo "Regenerating dics.dir file..."
		/usr/sbin/update-canna-dics_dir || die "Regenerating failed."
	fi
	einfo "Please restart cannaserver to fit changes."
	einfo "and modify your config file (~/.canna ) to enable dictionay."
	einfo " e.g) add \"gcanna\" \"gcannaf\" to section use-dictionary()"
	einfo "For details, see /usr/share/doc/${P}/README.gz"
}

pkg_postrm() {
	if [ -x /usr/sbin/update-canna-dics_dir ]; then
		einfo "Regenerating dics.dir file..."
		/usr/sbin/update-canna-dics_dir || die "Regenerating failed."
	fi
	einfo "Please restart cannaserver to fit changes."
	einfo "and modify your config file (~/.canna ) to disable dictionay."
	einfo " e.g) delete \"gcanna\" \"gcannaf\" from section use-dictionary()"
}
