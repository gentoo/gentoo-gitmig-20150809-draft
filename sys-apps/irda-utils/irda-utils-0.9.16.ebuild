# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irda-utils/irda-utils-0.9.16.ebuild,v 1.1 2004/10/03 10:53:09 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="IrDA Utilities, tools for IrDA communication"
HOMEPAGE="http://irda.sourceforge.net/"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	=dev-libs/glib-1.2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-__FUNCTIONS__.patch
}

src_compile() {
	export WANT_AUTOMAKE=1.6
	export WANT_AUTOCONF=2.5
	append-flags -I"${S}/include"
	emake \
		CFLAGS="${CFLAGS}" \
		RPM_OPT_FLAGS="${CFLAGS}" \
		RPM_BUILD_ROOT="${T}" \
		SYS_INCLUDES="" \
		SYS_LIBPATH="" \
		|| die "make failed"
	cd irsockets
	emake || die "make irsockets failed"
}

src_install() {
	dodir /usr/bin /usr/sbin
	make install PREFIX="${D}" ROOT="${D}" || die "Couldn't install from ${S}"

	# irda-utils's install-etc installs files in /etc/sysconfig if
	# that directory exists on the system, so clean up just in case.
	# This is for bug 1797 (17 Jan 2004 agriffis)
	rm -rf ${D}/etc/sysconfig 2>/dev/null

	dobin irsockets/{irdaspray,ias_query,irprintf{,x},irscanf,{recv,send}_ultra} \
		|| die "dobin irsockets"

	# install README's into /usr/share/doc
	local i
	for i in * ; do
		if [ -d "$i" -a "$i" != "man" ]; then
			if [ -f "$i/README" ] ; then
				newdoc README "README.$i"
			fi
		fi
	done

	insinto /etc/conf.d ; newins ${FILESDIR}/irda.conf irda
	insinto /etc/init.d ; insopts -m0755 ; newins ${FILESDIR}/irda.rc irda
}
