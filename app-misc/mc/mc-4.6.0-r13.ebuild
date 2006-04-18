# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.6.0-r13.ebuild,v 1.14 2006/04/18 18:06:07 nelchael Exp $

inherit flag-o-matic eutils

DESCRIPTION="GNU Midnight Commander cli-based file manager"
HOMEPAGE="http://www.ibiblio.org/mc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/managers/${PN}/${P}.tar.gz
	http://www.spock.mga.com.pl/public/gentoo/${P}-sambalib-3.0.0.patch.bz2
	mirror://gentoo/${P}-can-2004-0226-0231-0232.patch.bz2
	slang? ( unicode? ( mirror://gentoo/${P}-utf8.patch.bz2 ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="X gpm ncurses nls pam samba slang unicode"

PROVIDE="virtual/editor"

RDEPEND=">=sys-fs/e2fsprogs-1.19
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )
	=dev-libs/glib-2*
	pam? ( >=sys-libs/pam-0.72 )
	gpm? ( >=sys-libs/gpm-1.19.3 )
	slang? ( >=sys-libs/slang-1.4.9-r1 )
	samba? ( >=net-fs/samba-3.0.0 )
	unicode? ( >=sys-libs/slang-1.4.9-r1 )
	X? ( || ( (
			x11-libs/libX11
			x11-libs/libICE
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libSM
			)
			virtual/x11
		)
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	epatch ${DISTDIR}/${P}-sambalib-3.0.0.patch.bz2

	epatch ${FILESDIR}/${P}-find.patch
	epatch ${FILESDIR}/${P}-cpan-2003-1023.patch
	epatch ${DISTDIR}/${P}-can-2004-0226-0231-0232.patch.bz2
	epatch ${FILESDIR}/${P}-can-2004-1004-1005-1092-1176.patch
	epatch ${FILESDIR}/${P}-vfs.patch
	epatch ${FILESDIR}/${P}-ftp.patch
	epatch ${FILESDIR}/${P}-largefile.patch
	epatch ${FILESDIR}/${P}-key.c.patch
	# Fix building with gcc4.
	epatch ${FILESDIR}/${P}-gcc4.patch

	if use unicode && use slang; then
		epatch ${DISTDIR}/${P}-utf8.patch.bz2
	fi
}

src_compile() {
	append-flags -I/usr/include/gssapi
	filter-flags -malign-double

	local myconf=""

	if ! use slang && ! use ncurses ; then
		myconf="${myconf} --with-screen=mcslang"
	elif use ncurses && ! use slang ; then
		myconf="${myconf} --with-screen=ncurses"
	else
		use slang && myconf="${myconf} --with-screen=slang"
	fi

	myconf="${myconf} `use_with gpm gpm-mouse`"

	use nls \
	    && myconf="${myconf} --with-included-gettext" \
	    || myconf="${myconf} --disable-nls"

	myconf="${myconf} `use_with X x`"

	use samba \
	    && myconf="${myconf} --with-samba --with-configdir=/etc/samba
				--with-codepagedir=/var/lib/samba/codepages --with-privatedir=/etc/samba/private" \
	    || myconf="${myconf} --without-samba"

	econf \
	    --with-vfs \
	    --with-gnu-ld \
	    --with-ext2undel \
	    --with-edit \
		--enable-charset \
	    ${myconf} || die

	emake || die
}

src_install() {
	 cat ${FILESDIR}/chdir-4.6.0.gentoo >>\
		 ${S}/lib/mc-wrapper.sh

	einstall || die

	# install cons.saver setuid, to actually work
	chmod u+s ${D}/usr/lib/mc/cons.saver

	dodoc ChangeLog AUTHORS MAINTAINERS FAQ INSTALL* NEWS README*

	insinto /usr/share/mc
	doins ${FILESDIR}/mc.gentoo

	insinto /usr/share/mc/syntax
	doins ${FILESDIR}/ebuild.syntax
	cd ${D}/usr/share/mc/syntax
	epatch ${FILESDIR}/${P}-ebuild-syntax.patch

	# http://bugs.gentoo.org/show_bug.cgi?id=71275
	rm -f ${D}/usr/share/locale/locale.alias
}

pkg_postinst() {
	einfo "Add the following line to your ~/.bashrc to"
	einfo "allow mc to chdir to its latest working dir at exit"
	einfo ""
	einfo "# Midnight Commander chdir enhancement"
	einfo "if [ -f /usr/share/mc/mc.gentoo ]; then"
	einfo "	. /usr/share/mc/mc.gentoo"
	einfo "fi"
}
