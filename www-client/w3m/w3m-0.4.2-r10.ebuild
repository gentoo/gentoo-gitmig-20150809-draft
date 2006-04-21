# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/w3m/w3m-0.4.2-r10.ebuild,v 1.3 2006/04/21 17:32:14 flameeyes Exp $

inherit eutils

W3M_CVS_PV="1.862"
W3M_P="${P}+cvs-${W3M_CVS_PV}"

W3M_M17N_CVS_PV="1.859"
W3M_M17N_P="w3m-cvs-${W3M_M17N_CVS_PV}-m17n"
LIBWC_PV="20030224"

DESCRIPTION="Lightweight text based WWW browser w3m with multilingual extension"
HOMEPAGE="http://w3m.sourceforge.net/
	http://www2u.biglobe.ne.jp/~hsaka/w3m/
	http://www.page.sannet.ne.jp/knabe/w3m/w3m.html"
SRC_URI="mirror://gentoo/${W3M_P}.tar.gz
	cjk? ( mirror://gentoo/libwc-${LIBWC_PV}.tar.gz
		http://www.page.sannet.ne.jp/knabe/w3m/${W3M_M17N_P}-1.diff.gz
	)"
#	nls? ( http://www.page.sannet.ne.jp/knabe/w3m/${W3M_M17N_P}-nls-1.diff.gz)

LICENSE="w3m"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc"
IUSE="X cjk gpm gtk imlib2 migemo ssl xface" # nls

RDEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	dev-lang/perl
	>=dev-libs/boehm-gc-6.2
	X? ( gtk? ( >=media-libs/gdk-pixbuf-0.22.0 )
		!gtk? ( imlib2? ( >=media-libs/imlib2-1.0.5 )
			!imlib2? ( >=media-libs/imlib-1.9.8 ) )
	)
	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	migemo? ( >=app-text/migemo-0.40 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/autoconf-2.58"

PROVIDE="virtual/w3m"

src_unpack() {
	unpack ${W3M_P}.tar.gz
	cd ${S}

	if use cjk ; then
		# libwc doesn't come with w3m-m17n now
		unpack libwc-${LIBWC_PV}.tar.gz

		unpack ${W3M_M17N_P}-1.diff.gz
		sed -i -e "/^--- w3m\/version.c.in/,+8d" ${W3M_M17N_P}-1.diff || die
		epatch ${W3M_M17N_P}-1.diff
		sed -i -e "s/0.4.2/0.4.2-m17n-20030308/" version.c.in || die
	fi

	epatch ${FILESDIR}/w3m-w3mman-gentoo.diff
	#use nls && epatch ${DISTDIR}/${W3M_M17N_P}-nls-1.diff.gz
	epatch ${FILESDIR}/${P}-imglib-gentoo.diff
}

src_compile() {
	local myconf migemo_command imglib

	if use X ; then
		myconf="${myconf} --enable-image=x11,fb $(use_enable xface)"
		if use gtk ; then
			imglib="gdk_pixbuf"
		elif use imlib2 ; then
			imglib="imlib2"
		else
			imglib="imlib"
		fi
	else
		myconf="${myconf} --enable-image=no"
	fi

	if use migemo ; then
		migemo_command="migemo -t egrep /usr/share/migemo/migemo-dict"
	else
		migemo_command="no"
	fi

	export WANT_AUTOCONF=2.5
	autoconf || die

	econf \
		--enable-keymap=w3m \
		--with-editor=/usr/bin/nano \
		--with-mailer=/bin/mail \
		--with-browser=/usr/bin/mozilla \
		--with-termlib=ncurses \
		--with-imglib="${imglib}" \
		--with-migemo="${migemo_command}" \
		$(use_enable gpm mouse) \
		$(use_enable ssl digest-auth) \
		$(use_with ssl) \
		${myconf} || die

	# make borks
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /usr/share/${PN}/Bonus
	doins Bonus/*
	dodoc README NEWS TODO ChangeLog
	docinto doc-en ; dodoc doc/*
	docinto doc-jp ; dodoc doc-jp/*
}
