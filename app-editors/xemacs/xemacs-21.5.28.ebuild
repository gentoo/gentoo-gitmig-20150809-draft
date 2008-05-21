# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/xemacs/xemacs-21.5.28.ebuild,v 1.2 2008/05/21 15:50:20 dev-zero Exp $

inherit autotools eutils

DESCRIPTION="highly customizable open source text editor and application development system"
HOMEPAGE="http://www.xemacs.org/"
SRC_URI="http://ftp.xemacs.org/pub/xemacs/beta/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="athena berkdb canna debug dnd esd freewnn gdbm gif gnome gpm gtk hesiod ipv6 jpeg kerberos ldap motif mule nas neXt ncurses png pop postgres purify quantify socks5 tooltalk tiff X Xaw3d xface xft xim xpm zlib"

DEPEND="virtual/libc
	!virtual/xemacs
	>=dev-libs/openssl-0.9.6
	>=media-libs/audiofile-0.2.3
	>=sys-libs/ncurses-5.2
	>=app-admin/eselect-emacs-0.7-r1
	berkdb? ( =sys-libs/db-1* >=sys-libs/gdbm-1.8.0 )
	canna? ( app-i18n/canna )
	dnd? ( x11-libs/dnd )
	esd? ( media-sound/esound )
	freewnn? ( app-i18n/freewnn )
	gdbm? ( sys-libs/gdbm )
	gif? ( media-libs/giflib )
	gnome? ( gnome-base/libgnomeui )
	gpm? ( sys-libs/gpm )
	gtk? ( =x11-libs/gtk+-1.2* )
	hesiod? ( net-dns/hesiod )
	jpeg? ( media-libs/jpeg )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	motif? ( x11-libs/openmotif )
	nas? ( media-libs/nas )
	ncurses? ( sys-libs/ncurses )
	png? ( media-libs/libpng )
	postgres? ( >=virtual/postgresql-server-7.2 )
	socks5? ( >=net-proxy/dante-1.1.13 )
	tiff? ( media-libs/tiff )
	xface? ( media-libs/compface )
	xft? ( virtual/xft )
	xpm? ( x11-libs/libXpm )
	zlib? ( >=sys-libs/zlib-1.1.4 )"

PDEPEND="app-xemacs/xemacs-base"

PROVIDE="virtual/xemacs"

src_compile() {
	local myconf=""

	if use X; then

		myconf="${myconf} --with-widgets=athena"
		myconf="${myconf} --with-dialogs=athena"
		myconf="${myconf} --with-menubars=lucid"
		myconf="${myconf} --with-scrollbars=lucid"
		if use motif ; then
			myconf="--with-widgets=motif"
			myconf="${myconf} --with-dialogs=motif"
			myconf="${myconf} --with-scrollbars=motif"
			myconf="${myconf} --with-menubars=lucid"
		fi
		if use athena ; then
			myconf="--with-scrollbars=athena"
		fi

		if use Xaw3d; then
			myconf="${myconf} --with-athena=3d"
		elif use neXt; then
			myconf="${myconf} --with-athena=next"
		else
			myconf="${myconf} --with-athena=xaw"
		fi

		use dnd && myconf="${myconf} --with-dragndrop --with-offix"

		myconf="${myconf} $(use_with tiff ) $(use_with png )"
		myconf="${myconf} $(use_with jpeg ) $(use_with xface )"
	else
		myconf="${myconf}
			--without-x
			--without-xpm
			--without-dragndrop
			--with-gif=no"
	fi

	if use mule ; then
		myconf="${myconf} --with-mule"

		if use xim ; then
			if use motif ; then
				myconf="${myconf} --with-xim=motif"
			else
				myconf="${myconf} --with-xim=xlib"
			fi
		else
			myconf="${myconf} --with-xim=no"
		fi

		myconf="${myconf} $(use_with canna ) $(use_with freewnn wnn )"
	fi

	# This determines the type of sounds we are playing
	local soundconf="native"

	# This determines how these sounds should be played
	use nas	&& soundconf="${soundconf},nas"
	use esd && soundconf="${soundconf},esd"

	myconf="${myconf} --with-sound=${soundconf}"

	if use gdbm || use berkdb ; then
		use gdbm && mydb="gdbm"

		use berkdb && mydb="${mydb},berkdb"

		myconf="${myconf} --with-database=${mydb}"
	else
		myconf="${myconf} --with-database=no"
	fi

	# Don't use econf because it uses options which this configure
	# script does not understand (like --host).
	./configure ${myconf} ${EXTRA_ECONF} \
		$(use_with debug ) \
		$(use_with gif ) \
		$(use_with gpm ) \
		$(use_with hesiod ) \
		$(use_with ipv6 ipv6-cname ) \
		$(use_with jpeg ) \
		$(use_with kerberos ) \
		$(use_with ldap ) \
		$(use_with ncurses ) \
		$(use_with png ) \
		$(use_with pop ) \
		$(use_with postgres postgresql ) \
		$(use_with purify ) \
		$(use_with quantify ) \
		$(use_with socks5 socks ) \
		$(use_with tiff ) \
		$(use_with tooltalk ) \
		$(use_with xface ) \
		$(use_with xpm ) \
		$(use_with zlib ) \
		--prefix=/usr \
		--with-msw=no \
		--with-site-lisp=yes \
		--with-site-modules=yes \
		|| die "The configure script failed to run properly"

	emake || die "emake failed"
}

src_install() {
	emake prefix="${D}"/usr \
		mandir="${D}"/usr/share/man/man1 \
		infodir="${D}"/usr/share/info \
		install gzip-el || die "emake install failed"

	# Rename some applications installed in bin so that it is clear
	# which application installed them and so that conflicting
	# packages (emacs) can't clobber the actual applications.
	# Addresses bug #62991.
	for i in b2m ctags etags rcs-checkin ; do
		mv "${D}"/usr/bin/${i} "${D}"/usr/bin/${i}-xemacs || die "mv ${i} failed"
	done

	# rename man pages
	for i in ctags etags; do
		mv "${D}"/usr/share/man/man1/${i}{,-xemacs}.1 || die "mv ${i}.1 failed"
	done

	# install base packages directories
	dodir /usr/lib/xemacs/xemacs-packages/
	dodir /usr/lib/xemacs/site-packages/
	dodir /usr/lib/xemacs/site-modules/
	dodir /usr/lib/xemacs/site-lisp/

	# remove extraneous info files
	cd "${D}"/usr/share/info
	rm -f dir info.info texinfo* termcap* standards*

	cd "${S}"
	dodoc BUGS CHANGES-* ChangeLog GETTING* INSTALL PROBLEMS README*
	dodoc "${FILESDIR}"/README.Gentoo

	insinto /usr/share/pixmaps
	newins "${S}"/etc/${PN}-icon.xpm ${PN}.xpm

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
	eselect emacs update --if-unset
}

pkg_postrm() {
	eselect emacs update --if-unset
}
