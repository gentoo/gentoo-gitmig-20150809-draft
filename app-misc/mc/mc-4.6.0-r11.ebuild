# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.6.0-r11.ebuild,v 1.12 2004/10/21 11:43:52 bazik Exp $

inherit flag-o-matic eutils

DESCRIPTION="GNU Midnight Commander cli-based file manager"
HOMEPAGE="http://www.ibiblio.org/mc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/managers/${PN}/${P}.tar.gz
	http://www.spock.mga.com.pl/public/gentoo/${P}-sambalib-3.0.0.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 x86 ppc sparc alpha ~mips hppa ~amd64 ~ppc64"
IUSE="gpm nls samba ncurses X slang unicode"

PROVIDE="virtual/editor"

DEPEND=">=sys-fs/e2fsprogs-1.19
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )
	=dev-libs/glib-2*
	pam? ( >=sys-libs/pam-0.72 )
	gpm? ( >=sys-libs/gpm-1.19.3 )
	slang? ( >=sys-libs/slang-1.4.9-r1 )
	samba? ( >=net-fs/samba-3.0.0 )
	unicode? ( >=sys-libs/slang-1.4.9-r1 )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	epatch ${DISTDIR}/${P}-sambalib-3.0.0.patch.bz2

	epatch ${FILESDIR}/${P}-find.patch
	epatch ${FILESDIR}/${P}-cpan-2003-1023.patch
	epatch ${FILESDIR}/${P}-can-2004-0226-0231-0232.patch.bz2
	epatch ${FILESDIR}/${P}-vfs.patch
	epatch ${FILESDIR}/${P}-ftp.patch
	epatch ${FILESDIR}/${P}-largefile.patch

	if use unicode && use slang; then
		epatch ${FILESDIR}/${P}-utf8.patch.bz2
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
