# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.4.ebuild,v 1.7 2004/01/04 18:35:30 usata Exp $

inherit eutils

IUSE="gpm cjk imlib ssl"

S=${WORKDIR}/${P}
DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="mirror://sourceforge/w3m/${P}.tar.gz"
HOMEPAGE="http://w3m.sourceforge.net/"

SLOT="0"
LICENSE="w3m"
KEYWORDS="x86 sparc alpha ~ppc"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	imlib? ( >=media-libs/imlib-1.9.8 media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/textbrowser"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use alpha; then
		epatch ${FILESDIR}/w3m-0.4-alpha.patch || die "epatch failed"
	fi
}

src_compile() {
	# It seems to be hard to configure this program in any reasonable
	# way.
	(
		# Which directory do you want to put the binary?
		echo /usr/bin
		# Which directory do you want to put the support binary files?
		echo /usr/lib/w3m
		# Which directory do you want to use local cgi?
		echo /usr/lib/w3m/cgi-bin
		# Which directory do you want to put the helpfile?
		echo /usr/share/w3m
		# Which directory do you want to put the manfile?
		echo /usr/share/man
		# Which directory do you want to put the system wide w3m
		# configuration file?
		echo /etc/w3m
		# Which language do you prefer?
		#  1 - Japanese (charset ISO-2022-JP, EUC-JP, Shift_JIS)
		#  2 - English (charset US_ASCII, ISO-8859-1, etc.)
		if use cjk &>/dev/null; then
			echo 1
			# What is your Kanji display
			echo E
			# Use 2-byte character for table border, etc
			echo n
		else
			echo 2
		fi
		# Use Lynx-like key binding as default [n]?
		echo n
		# Let's do some configurations. Choose config option among the list.
		#
		# 1 - Baby model    (no color, no menu, no mouse, no cookie, no SSL)
		# 2 - Little model  (color, menu, no mouse, no cookie, no SSL)
		# 3 - Mouse model   (color, menu, mouse, no cookie, no SSL)
		# 4 - Cookie model  (color, menu, mouse, cookie, no SSL)
		# 5 - Monster model (with everything; you need openSSL library)
		# 6 - Customize
		#
		# Which?
		echo 6
		# Do you want color ESC sequence for Kterm/pxvt
		echo y
		# Use mouse (requires xterm/kterm/gpm/sysmouse)
		use gpm &>/dev/null && echo y || echo n
		# Use popup menu
		echo y
		# Use cookie
		echo y
		# Do you want SSL verification support?
		# (Your SSL library must be version 0.8 or later)
		if use ssl &>/dev/null; then
			echo y
			# (ssl) SSL verification support (SSL library >= version 0.8) [n]?
			echo n
			# (ssl) Digest Auth support [y]?
			echo y
		else
			echo n
		fi
		# Inline image support?
		if use imlib &>/dev/null; then
			echo y
			# X11 inline image support (you need Imlib, Imlib2 or
			# GdkPixbuf library) [y]?
			echo y
			# Linux Framebuffer inline image support (you need Imlib2
			# or GdkPixbuf) [n]?
			echo y
			# setuid w3mimgdisplay to open /dev/fb0? [y]?
			echo n
		else
			echo n
		fi
		# ANSI color escape sequences support [n]?
		echo y
		# Use Migemo (Roma-ji search; Please see
		# http://migemo.namazu.org/) [n]?
		echo n
		# External URI loader support [y]?
		echo y
		# Use w3mmail.cgi [y]?
		echo y
		# NNTP support [y]?
		echo n
		# Gopher support [y]?
		echo n
		# Use alarm support code [y]?
		echo y
		# Use mark operation [y]?
		echo y
		if use imlib &>/dev/null; then
			# X-Face support (you need uncompface) [n]?
			echo y
		fi
		# Input your favorite editor program.
		echo ${EDITOR:-/usr/bin/nano}
		# Input your favorite external browser program.
		echo /usr/bin/mozilla
		# Input your favorite C-compiler.
		echo gcc
		# Input your favorite C flags.
		printf "%s\n" "$CFLAGS"
		# Which terminal library do you want to use? (type "none" if you
		# do not need one)
		echo
		#printf "%s\n" "-lncurses"
		# Input additional LD flags other than listed above, if any:
		# (default: -lncurses) :
		echo
	) | ./configure || die "configure failed"

	# Test to make sure the above configuration was sane
	grep -q "dcc='gcc'" config.param || \
		die "configure out of sync; ebuild needs an update"

	# binary executables come prebuilt for 80386!
	# clean it up and be sure to remake for ANY arch
	cd ${S}/gc
	make clean
	cd -

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc doc/* README*
	doman doc/w3m.1
}
