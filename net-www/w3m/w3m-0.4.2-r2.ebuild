# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.4.2-r2.ebuild,v 1.1 2003/10/31 15:41:06 usata Exp $

IUSE="X nopixbuf imlib imlib2 xface ssl migemo gpm cjk"

W3M_CVS_PV="1.890"
W3M_CVS_P="${P}+cvs-${W3M_CVS_PV}"

DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="mirror://gentoo/${W3M_CVS_P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${W3M_CVS_P}.tar.gz"
HOMEPAGE="http://w3m.sourceforge.net/"

SLOT="0"
LICENSE="w3m"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"
RDEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	>=dev-libs/boehm-gc-6.2
	X? ( || ( !nopixbuf? ( >=media-libs/gdk-pixbuf-0.22.0 )
		imlib2? ( >=media-libs/imlib2-1.0.5 )
		imlib? ( >=media-libs/imlib-1.9.8 )
		virtual/glibc )
	)
	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	migemo? ( >=app-text/migemo-0.40 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/textbrowser
	virtual/w3m"

S="${WORKDIR}/${P}"

pkg_setup() {

	if [ -n "`use X`" -a -n "`use nopixbuf`" -a -z "`use imlib2`" -a -z "`use imlib`" ] ; then
		ewarn
		ewarn "If you set USE=\"nopixbuf\" (disable gdk-pixbuf for w3mimgdisplay),"
		ewarn "you need to enable either imlib2 or imlib USE flag."
		ewarn
		die "w3m requires gdk-pixbuf, imlib2 or imlib for image support."
	fi
}

w3m_src_compile() {

	local myconf migemo_command imglib

	if [ -n "`use X`" ] ; then
		myconf="${myconf} --enable-image=x11,fb `use_enable xface`"
		if [ ! -n "`use nopixbuf`" ] ; then
			imglib="gdk_pixbuf"
		elif [ -n "`use imlib2`" ] ; then
			imglib="imlib2"
		elif [ -n "`use imlib`" ] ; then
			imglib="imlib"
		else
			# defaults to gdk_pixbuf
			imglib="gdk_pixbuf"
		fi
	else
		myconf="${myconf} --enable-image=no"
	fi

	if [ -n "`use migemo`" ] ; then
		migemo_command="migemo -t egrep /usr/share/migemo/migemo-dict"
	else
		migemo_command="no"
	fi

	# You can't disable nls at the moment(w3mhelper hangs)
	# `use_enable nls`
	econf --enable-keymap=w3m \
		--with-editor=/usr/bin/nano \
		--with-mailer=/bin/mail \
		--with-browser=/usr/bin/mozilla \
		--with-termlib=ncurses \
		--with-imglib="${imglib}" \
		--with-migemo="${migemo_command}" \
		`use_enable cjk m17n` \
		`use_enable gpm mouse` \
		`use_enable ssl digest-auth` \
		`use_with ssl` \
		${myconf} "$@" || die

	# emake borked
	make all || die "make failed"
	make all || die "make failed"
}

src_unpack() {

	unpack ${W3M_CVS_P}.tar.gz
	cd ${S}
	#epatch ${FILESDIR}/${PF}-gentoo.diff
	#epatch ${FILESDIR}/${P}-w3mman-gentoo.diff
	epatch ${FILESDIR}/${PN}-w3mman-gentoo.diff
	#epatch ${FILESDIR}/${P}-imglib-gentoo.diff
}

src_compile() {

	export WANT_AUTOCONF_2_5=1
	autoconf || die

	if [ -n "`use cjk`" ] ; then

		w3m_src_compile \
			--enable-japanese=E \
			--with-charset=EUC-JP \
			--enable-messagel10n

		mv w3mhelperpanel ${T}/w3mhelperpanel-ja
		mv w3mbookmark ${T}/w3mbookmark-ja
		mv w3m ${T}/w3m-ja

		sed -e "s%@cgibindir@%/usr/libexec/w3m/cgi-bin%" \
			${FILESDIR}/w3mhelperpanel.sh.in \
			> ${T}/w3mhelperpanel.sh
		sed -e "s%@cgibindir@%/usr/libexec/w3m/cgi-bin%" \
			${FILESDIR}/w3mbookmark.sh.in \
			> ${T}/w3mbookmark.sh

		make clean
	fi

	w3m_src_compile --disable-japanese
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	if [ -n "`use cjk`" ] ; then
		mv ${D}/usr/bin/w3m{,-en}
		mv ${D}/usr/libexec/w3m/cgi-bin/w3mhelperpanel{,-en}
		mv ${D}/usr/libexec/w3m/cgi-bin/w3mbookmark{,-en}
		dobin ${T}/w3m-ja
		newbin ${FILESDIR}/w3m.sh w3m
		exeinto /usr/libexec/w3m/cgi-bin
		doexe ${T}/w3mhelperpanel-ja
		doexe ${T}/w3mbookmark-ja
		newexe ${T}/w3mhelperpanel.sh w3mhelperpanel
		newexe ${T}/w3mbookmark.sh w3mbookmark
	fi

	insinto /usr/share/${PN}/Bonus
	doins Bonus/*
	dodoc README NEWS TODO ChangeLog
	docinto doc-en ; dodoc doc/*
	if [ -n "`use cjk`" ] ; then
		docinto doc-jp ; dodoc doc-jp/*
	else
		rm -rf ${D}/usr/share/man/ja
	fi
}
