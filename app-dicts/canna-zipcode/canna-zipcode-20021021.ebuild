# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/canna-zipcode/canna-zipcode-20021021.ebuild,v 1.1 2003/05/17 19:31:14 nakano Exp $

MY_P="${P/canna-/}"

DESCRIPTION="Japanese Zipcode dictionary for Canna"
HOMEPAGE="http://bonobo.gnome.gr.jp/~nakai/canna/"
SRC_URI="http://bonobo.gnome.gr.jp/~nakai/canna/${MY_P}.tar.bz2"
LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND=">=canna-3.6_p3-r1 app-i18n/nkf app-arch/lha"
RDEPEND=">=canna-3.6_p3-r1"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f zipcode.t jigyosyo.t ken_all.{lzh,csv} jigyosyo.{lzh.csv} || die
	wget http://www.post.japanpost.jp/zipcode/dl/kogaki/lzh/ken_all.lzh \
		http://www.post.japanpost.jp/zipcode/dl/jigyosyo/lzh/jigyosyo.lzh
	lha e ken_all.lzh
	lha e jigyosyo.lzh
	touch *.csv
}

src_compile() {
	make all || die
	mkbindic zipcode.t ; mkbindic jigyosyo.t
}

src_install() {
	dodir /var/lib/canna/dic/canna/
	install -o bin -g bin -m 0664 zipcode.c[bl]d jigyosyo.c[bl]d \
		${D}/var/lib/canna/dic/canna/
	insinto /var/lib/canna/dic/dics.d/ ;\
		doins ${FILESDIR}/02zipcode.dics.dir
	dodoc COPYING README.jp
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
