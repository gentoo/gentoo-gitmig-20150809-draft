# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irda-utils/irda-utils-0.9.15.ebuild,v 1.14 2004/09/03 21:03:23 pvdabeel Exp $

DESCRIPTION="IrDA Utilities, tools for IrDA communication"
HOMEPAGE="http://irda.sourceforge.net/"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/glib-1.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	export WANT_AUTOCONF=2.5
}

src_compile() {
	make ROOT="${D}" RPM_BUILD_ROOT="${D}" || die "Making failed."
	cd irsockets
	make || die "Making irsockets failed."
}

src_install () {
	dodir /usr/bin
	dodir /usr/sbin
	dodir /usr/X11R6/bin

	make install PREFIX="${D}" ROOT="${D}" || die "Couldn't install from ${S}"

	# irda-utils's install-etc installs files in /etc/sysconfig if
	# that directory exists on the system, so clean up just in case.
	# This is for bug 1797 (17 Jan 2004 agriffis)
	rm -rf ${D}/etc/sysconfig 2>/dev/null

	into /usr
	dobin irsockets/irdaspray
	dobin irsockets/ias_query
	dobin irsockets/irprintf
	dobin irsockets/irprintfx
	dobin irsockets/irscanf
	dobin irsockets/recv_ultra
	dobin irsockets/send_ultra

	# install README's into /usr/share/doc
	for i in *
	do
		if [ -d $i -a $i != "man" ]; then
			if [ -f $i/README ]; then
				cp $i/README README.$i
				dodoc README.$i
				rm README.$i
			fi
		fi
	done

	insinto /etc/conf.d ; newins ${FILESDIR}/irda.conf irda
	insinto /etc/init.d ; insopts -m0755 ; newins ${FILESDIR}/irda.rc irda
}
