# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/canna-zipcode/canna-zipcode-20021021-r1.ebuild,v 1.1 2003/07/26 05:22:36 nakano Exp $

MY_P="${P/canna-/}"
MY_DATE="030726"

DESCRIPTION="Japanese Zipcode dictionary for Canna"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/canna/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/canna/${MY_P}.tar.bz2
	http://gentoojp.sourceforge.jp/distfiles/ken_all_${MY_DATE}.lzh
	http://gentoojp.sourceforge.jp/distfiles/jigyosyo_${MY_DATE}.lzh"
LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND=">=app-i18n/canna-3.6_p3-r1 app-i18n/nkf app-arch/lha"
RDEPEND=">=app-i18n/canna-3.6_p3-r1"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.bz2
	cd ${S}
	lha e ${DISTDIR}/ken_all_${MY_DATE}.lzh
	lha e ${DISTDIR}/jigyosyo_${MY_DATE}.lzh
	touch *.csv
}

src_compile() {
	make all || die
	mkbindic zipcode.t ; mkbindic jigyosyo.t || die
}

src_install() {
	dodir /var/lib/canna/dic/canna/
	install -o bin -g bin -m 0664 zipcode.c[bl]d jigyosyo.c[bl]d \
		${D}/var/lib/canna/dic/canna/ || die
	insinto /var/lib/canna/dic/dics.d/ ;\
		doins ${FILESDIR}/02zipcode.dics.dir || die
	dodoc COPYING README.jp || die
}

pkg_postinst() {
	if [ -x /usr/sbin/update-canna-dics_dir ]; then
		einfo "Regenerating dics.dir file..."
		/usr/sbin/update-canna-dics_dir || die "Regenerating failed."
	fi
	einfo "Please restart cannaserver to fit changes."
	einfo "and modify your config file (~/.canna ) to enable dictionay."
	einfo " e.g) add \"zipcode\" \"jigyosyo\" to section use-dictionary()"
	einfo "For details, see /usr/share/doc/${P}/README.jp.gz"
}

pkg_postrm() {
	if [ -x /usr/sbin/update-canna-dics_dir ]; then
		einfo "Regenerating dics.dir file..."
		/usr/sbin/update-canna-dics_dir || die "Regenerating failed."
	fi
	einfo "Please restart cannaserver to fit changes."
	einfo "and modify your config file (~/.canna) to disable dictionay."
	einfo " e.g) delete \"zipcode\" \"jigyosyo\" from section use-dictionary()"
}
