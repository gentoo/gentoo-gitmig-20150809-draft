# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen/screen-3.9.13-r3.ebuild,v 1.1 2002/12/20 16:48:35 blizzy Exp $

inherit flag-o-matic

IUSE="pam"
DESCRIPTION="Screen is a full-screen window manager that multiplexes a physical terminal between several processes"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/utilities/screen/${P}.tar.gz"
HOMEPAGE="http://www.math.fu-berlin.de/~guckes/screen/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=sys-libs/ncurses-5.2
	pam? ( >=sys-libs/pam-0.75 )"

src_unpack() {
	unpack ${A} && cd ${S}

	# Fix manpage.
	mv doc/screen.1 doc/screen.1.orig
	sed <doc/screen.1.orig >doc/screen.1 \
		-e "s:/usr/local/etc/screenrc:/etc/screenrc:g;
		s:/usr/local/screens:/var/run/screen:g;
		s:/local/etc/screenrc:/etc/screenrc:g;
		s:/etc/utmp:/var/run/utmp:g;
		s:/local/screens/S-:/var/run/screen/S-:g"
}

src_compile() {
	local myconf

	addpredict "`tty`"
	addpredict "${SSH_TTY}"

	# check config.h for other settings such as the 
	# max-number of windows allowed by screen.
	append-flags "-DPTYMODE=0620 -DPTYGROUP=5"
	use pam && myconf="--enable-pam" && append-flags "-DUSE_PAM"

	econf 	--with-socket-dir=/var/run/screen \
		--with-sys-screenrc=/etc/screenrc \
		--enable-rxvt_osc ${myconf}

	emake || die "Failed to compile"
}

src_install () {
	dobin screen
	fperms 2755 /usr/bin/screen

	dodir /var/run/screen
	touch ${D}/var/run/screen/.keep

	# can't use this cause fowners do not support multiple args.
	# fowners root.utmp /{usr/bin,var/run}/screen
	chown root.utmp ${D}/{usr/bin,var/run}/screen

	insinto /usr/share/terminfo ; doins terminfo/screencap
	insinto /usr/share/screen/utf8encodings ; doins utf8encodings/??
	insopts -m 644 ; insinto /etc ; doins ${FILESDIR}/screenrc

	use pam && { insinto /etc/pam.d ; newins ${FILESDIR}/screen.pam screen ; }

	dodoc README ChangeLog INSTALL COPYING TODO NEWS* \
	doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps}

	doman doc/screen.1
	doinfo doc/screen.info*
}

pkg_postinst() {
	chmod 0775 /var/run/screen

	einfo "Some dangerous key bindings have been removed or changed to more safe values."
	einfo "For more info, please check /etc/screenrc"
	echo
	einfo "screen is not installed as setuid root, which effectively disables multi-user"
	einfo "mode. To enable it, run:"
	einfo ""
	einfo "\tchmod u+s /usr/bin/screen"
	einfo "\tchmod g-w /var/run/screen"
}
