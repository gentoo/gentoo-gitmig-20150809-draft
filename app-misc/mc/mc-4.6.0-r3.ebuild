# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.6.0-r3.ebuild,v 1.11 2003/12/26 13:57:28 lanius Exp $

inherit flag-o-matic

IUSE="gpm nls samba ncurses X slang"

S=${WORKDIR}/${P}
DESCRIPTION="GNU Midnight Commander cli-based file manager"
HOMEPAGE="http://www.ibiblio.org/mc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/managers/${PN}/${P}.tar.gz
	http://www.spock.mga.com.pl/public/gentoo/${P}-sambalib.patch.bz2
	http://www.spock.mga.com.pl/public/gentoo/${P}-samba.patch.bz2"

DEPEND=">=sys-fs/e2fsprogs-1.19
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )
	=dev-libs/glib-2*
	>=sys-libs/pam-0.72
	gpm? ( >=sys-libs/gpm-1.19.3 )
	slang? ( >=sys-libs/slang-1.4.2 )
	samba? ( >=net-fs/samba-2.2.3a-r1 )
	X? ( virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ia64 x86 ppc sparc alpha mips hppa arm amd64"

filter-flags -malign-double

src_unpack() {
	unpack ${P}.tar.gz
	has_version '>=net-fs/samba-3.0.0' &&
		epatch ${DISTDIR}/mc-4.6.0-samba.patch.bz2
	has_version '<net-fs/samba-3.0.0' &&
		epatch ${DISTDIR}/mc-4.6.0-sambalib.patch.bz2
	epatch ${FILESDIR}/mc-4.6.0-find.patch
}

src_compile() {
	local myconf=""

	if ! use slang && ! use ncurses
	    then
		myconf="${myconf} --with-screen=mcslang"
	    elif
		use ncurses && ! use slang
	    then
		myconf="${myconf} --with-screen=ncurses"
	    else
		use slang && myconf="${myconf} --with-screen=slang"
	fi

	use gpm \
	    && myconf="${myconf} --with-gpm-mouse" \
	    || myconf="${myconf} --without-gpm-mouse"

	use nls \
	    && myconf="${myconf} --with-included-gettext" \
	    || myconf="${myconf} --disable-nls"

	use X \
	    && myconf="${myconf} --with-x" \
	    || myconf="${myconf} --without-x"

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

	# bug 27212
	sed -i '/#define HAVE_SYS_CAPABILITY_H 1/a#define _LINUX_VFS_H' vfs/samba/include/config.h

	emake || die
}

src_install() {
	 cat ${FILESDIR}/chdir-4.6.0.gentoo >>\
	 ${S}/lib/mc-wrapper.sh

	einstall || die

	dodoc ABOUT-NLS COPYING* ChangeLog AUTHORS MAINTAINERS FAQ INSTALL* NEWS README*

	insinto /usr/share/mc
	doins ${FILESDIR}/mc.gentoo
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
