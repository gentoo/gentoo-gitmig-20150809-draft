# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/wwwoffle/wwwoffle-2.7h.ebuild,v 1.2 2004/09/03 16:06:50 pvdabeel Exp $

DESCRIPTION="wwwoffle = WWW Offline Explorer, an adv. caching proxy especially suitable for nonpermanent (e.g. dialup) Internet connections"

SRC_URI="ftp://ftp.demon.co.uk/pub/unix/httpd/${P}.tgz
	 ftp://ftp.ibiblio.org/pub/Linux/apps/www/servers/${P}.tgz"

HOMEPAGE="http://www.gedanken.demon.co.uk/"
KEYWORDS="x86 ~sparc ppc ppc64"
SLOT="0"
LICENSE="GPL-2"
IUSE="ipv6"
DEPEND="sys-devel/flex
	sys-libs/zlib
	sys-devel/gcc
	virtual/libc
	>=sys-apps/sed-4"

RDEPEND="sys-libs/zlib
	virtual/libc"

src_compile() {
	local myconf
	use ipv6	&& myconf="$myconf --with-ipv6" 	|| myconf="$myconf --without-ipv6"
	./configure $myconf --prefix=/usr --with-confdir=/etc	|| die

	emake || die
}

src_install() {

	sed -i -e 's#$(TAR) xpf #$(TAR) --no-same-owner -xpf #' cache/Makefile

	# Install the files
	make prefix=${D}/usr SPOOLDIR=${D}/var/spool/wwwoffle CONFDIR=${D}/etc install || die

	cd ${D}/etc
	sed -i -e "s:${D}::"  wwwoffle.conf

	# Install the wwwoffled init script
	exeinto /etc/init.d
	doexe ${FILESDIR}/{wwwoffled-online,wwwoffled}

	# someday i'll make it use the file in /etc. for now we at least get
	# config file protection this way.
	dosym /etc/wwwoffle.conf /var/spool/wwwoffle/wwwoffle.conf
}

pkg_preinst() {
	source /etc/init.d/functions.sh
	if [ -L ${svcdir}/started/wwwoffled ]; then
		einfo "The wwwoffled init script is running. I'll stop it, merge the new files and
		restart the script."
		/etc/init.d/wwwoffled stop
		touch ${T}/restart
	fi
}

pkg_postinst() {
	if [ -f "${T}/restart" ]; then
		einfo "Starting the wwwoffled initscript again..."
		/etc/init.d/wwwoffled start
		rm ${T}/restart
	fi
}
