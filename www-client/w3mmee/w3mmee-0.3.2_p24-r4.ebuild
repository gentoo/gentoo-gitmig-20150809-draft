# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/w3mmee/w3mmee-0.3.2_p24-r4.ebuild,v 1.4 2006/04/21 17:33:44 flameeyes Exp $

inherit alternatives eutils

IUSE="gpm imlib nls ssl"

MY_PV=${PV##*_}-20
MY_P=${PN}-${MY_PV}
GC_PV="6.2"
MY_GC=gc${GC_PV}

DESCRIPTION="A variant of w3m with support for multiple character encodings"
SRC_URI="http://pub.ks-and-ks.ne.jp/prog/pub/${MY_P}.tar.gz
	http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/${MY_GC}.tar.gz"
HOMEPAGE="http://pub.ks-and-ks.ne.jp/prog/w3mmee/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 -alpha sparc ppc"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	>=dev-libs/boehm-gc-6.2
	dev-lang/perl
	>=dev-libs/libmoe-1.5.3
	imlib? ( >=media-libs/imlib-1.9.8
		media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	nls? ( sys-devel/gettext )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/w3m"

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack ${MY_P}.tar.gz
	cd ${S}

	# w3mmee doesn't come with boehm-gc unlike w3m and w3m-m17n.
	# However, w3mmee cannot be compiled with system gc
	# (Debian is the only Linux distribution that can compile it)
	unpack ${MY_GC}.tar.gz
	mv ${MY_GC} gc

	epatch ${FILESDIR}/${PN}-w3mman-gentoo.diff
}

src_compile() {

	local myconf myuse mylang
	myuse="use_cookie=y use_ansi_color=y use_history=y
		display_code=E system_code=E"

	if use ssl ; then
		myconf="${myconf} --ssl-includedir=/usr/include/openssl
			--ssl-libdir=/usr/lib"
		myuse="${myuse} use_ssl=y use_ssl_verify=y
			use_digest_auth=y"
	else
		myuse="${myuse} use_ssl=n"
	fi

	if use gpm ; then
		myuse="${myuse} use_mouse=y"
	else
		myuse="${myuse} use_mouse=n"
	fi

	if use nls ; then
		myconf="${myconf} -locale_dir=/usr/share/locale"
	else
		myconf="${myconf} -locale_dir='(NONE)'"
	fi

	if use imlib ; then
		myuse="${myuse} use_image=y use_w3mimg_x11=y
		use_w3mimg_fb=n w3mimgdisplay_setuid=n use_xface=y"
	else
		myuse="${myuse} use_image=n"
	fi

	cat >>config.param<<-EOF
	lang=MANY
	accept_lang=en
	EOF

	env ${myuse} ./configure -nonstop \
		-prefix=/usr \
		-suffix=mee \
		-auxbindir=/usr/lib/w3mmee \
		-libdir=/usr/lib/w3mmee/cgi-bin \
		-helpdir=/usr/share/w3mmee \
		-mandir=/usr/share/man \
		-sysconfdir=/etc/w3mmee \
		-model=custom \
		-libmoe=/usr/lib \
		-mb_h=/usr/include/moe \
		-mk_btri=/usr/libexec/moe \
		-cflags=${CFLAGS} -ldflags=${LDFLAGS} \
		${myconf} || die

	emake || die "emake failed"
}

src_install() {

	einstall DESTDIR=${D}

	# w3mman and manpages conflict with those from w3m
	mv ${D}/usr/bin/w3m{,mee}man
	mv ${D}/usr/share/man/ja/man1/w3m{,mee}.1
	mv ${D}/usr/share/man/man1/w3m{,mee}.1
	mv ${D}/usr/share/man/man1/w3mman{,mee}.1

	dodoc 00INCOMPATIBLE.html ChangeLog NEWS* README
	docinto en
	dodoc doc/*
	docinto jp
	dodoc doc-jp/*
}

pkg_postinst() {

	w3m_alternatives
	einfo
	einfo "If you want to render multilingual text, please refer to"
	einfo "/usr/share/doc/${P}/en/README.mee or"
	einfo "/usr/share/doc/${P}/jp/README.mee"
	einfo "and set W3MLANG variable respectively."
	einfo
}

pkg_postrm() {

	w3m_alternatives
}

w3m_alternatives() {

	if [ ! -f /usr/bin/w3m ] ; then
		alternatives_makesym /usr/bin/w3m \
			/usr/bin/w3m{m17n,mee}
		alternatives_makesym /usr/bin/w3mman \
			/usr/bin/w3m{man-m17n,meeman}
		alternatives_makesym /usr/share/man/ja/man1/w3m.1.gz \
			/usr/share/man/ja/man1/w3m{m17n,mee}.1.gz
		alternatives_makesym /usr/share/man/man1/w3m.1.gz \
			/usr/share/man/man1/w3m{m17n,mee}.1.gz
		alternatives_makesym /usr/share/man/man1/w3mman.1.gz \
			/usr/share/man/man1/w3m{man-m17n,meeman}.1.gz
	fi
}
