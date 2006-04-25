# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-it/man-pages-it-0.3.4.ebuild,v 1.4 2006/04/25 14:47:29 truedfx Exp $

DESCRIPTION="A somewhat comprehensive collection of Italian Linux man pages"
HOMEPAGE="http://it.tldp.org/man/"
SRC_URI="http://ftp.pluto.it/pub/pluto/ildp/man/${P}.tar.gz"

LICENSE="LDP-1a"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^ZIP/s:=.*:=:' \
		-e 's:X11R6/::' \
		-e '/mandir=/s:/man:/share/man:' \
		Makefile
	# remove manpages that other packages provide
	#  - shadow #117738, man & vim #127002
	cd "${S}"/man1
	rm newgrp.1 chage.1 groups.1 login.1 chsh.1 gpasswd.1 passwd.1 su.1 chfn.1 \
		apropos.1 man.1 whatis.1 vim.1
	cd "${S}"/man5
	rm shadow.5
	cd "${S}"/man8
	rm groupadd.8 grpconv.8 usermod.8 groupdel.8 pwconv.8 vipw.8 lastlog.8 \
		groupmod.8 pwck.8 newusers.8 useradd.8 pwunconv.8 grpck.8 userdel.8 \
		vigr.8 grpunconv.8 makewhatis.8
}

src_compile() { :; }

src_install() {
	make install prefix="${D}"/usr || die
	dodoc CONTRIB NEW README* TODO
}
