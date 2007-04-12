# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/irda-utils/irda-utils-0.9.16-r1.ebuild,v 1.8 2007/04/12 21:23:09 betelgeuse Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.4"

inherit eutils autotools

DESCRIPTION="IrDA utilities for infrared communication"
HOMEPAGE="http://irda.sourceforge.net/"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk"

DEPEND="=dev-libs/glib-1.2*
	gtk? ( =x11-libs/gtk+-1.2* )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/irda-utils-rh1.patch"
	epatch "${FILESDIR}/irda-utils-gcc3.4-fix.patch"
	epatch "${FILESDIR}/${P}-irkbd.patch"
}

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.4
	export RPM_OPT_FLAGS=${CFLAGS}

	emake ROOT="${D}" RPM_BUILD_ROOT="${D}" || die "Making failed."

	cd ${S}/irsockets
	emake || die "Making irsockets failed."

	if use gtk; then
		cd ${S}/findchip
		emake gfindchip || die "Making gfindchip failed."
	fi
}

src_install () {
	dodir /usr/bin
	dodir /usr/sbin

	emake install PREFIX="${D}" ROOT="${D}" MANDIR="${D}/usr/share/man" \
		|| die "Couldn't install from ${S}"

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

	if use gtk; then
		dosbin findchip/gfindchip
	fi

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

	dodoc etc/modules.conf.irda

	newconfd "${FILESDIR}/irda.conf" irda
	newinitd "${FILESDIR}/irda.rc" irda
}
