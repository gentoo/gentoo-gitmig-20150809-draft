# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apmd/apmd-3.2.2_p5.ebuild,v 1.3 2006/04/30 23:47:05 josejx Exp $

inherit eutils multilib

MY_PV="${PV%_p*}"
MY_P="${PN}_${MY_PV}"
PATCHV="${PV#*_p}"

DESCRIPTION="Advanced Power Management Daemon"
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/apmd/"
SRC_URI="mirror://debian/pool/main/a/apmd/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/a/apmd/${MY_P}-${PATCHV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc ~ppc64 ~x86"
IUSE="X nls"

RDEPEND=">=sys-apps/debianutils-1.16
	>=sys-power/powermgmt-base-1.22
	X? ( || ( ( x11-libs/libX11
				x11-libs/libXaw
				x11-libs/libXmu
				x11-libs/libSM
				x11-libs/libICE
				x11-libs/libXt
				x11-libs/libXext )
				virtual/x11 ) )"
DEPEND="${RDEPEND}
	virtual/os-headers"

S=${WORKDIR}/${PN}-${MY_PV}.orig

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${MY_P}-${PATCHV}.diff
	# We depend on powermgmt-base now, so no need to install the script
	# included with apmd.
	epatch "${FILESDIR}"/${PN}-no-on_ac_power_script.patch

	if ! use X ; then
		sed -i \
			-e 's:\(EXES=.*\)xapm:\1:' \
			-e 's:\(.*\)\$(LT_INSTALL).*xapm.*$:\1echo:' \
			"${S}"/Makefile \
			|| die "sed failed"
	fi
	# apmd is perfectly happy with system linux-headers
	sed -e 's:-I/usr/src/linux/include::' -i "${S}"/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/sbin

	make DESTDIR="${D}" PREFIX=/usr LIBDIR=/usr/$(get_libdir) install \
		|| die "install failed"

	keepdir /etc/apm/{event.d,suspend.d,resume.d,other.d,scripts.d}
	exeinto /etc/apm
	doexe debian/apmd_proxy || die "doexe failed"
	dodoc AUTHORS apmsleep.README README debian/README.Debian \
		debian/changelog* debian/copyright*

	doman *.1 *.8

	# note: apmd_proxy.conf is currently disabled and not used, thus
	#       not installed - liquidx (01 Mar 2004)

	insinto /etc/conf.d
	newins "${FILESDIR}"/apmd.confd apmd || die "newins failed"
	exeinto /etc/init.d
	newexe "${FILESDIR}"/apmd.rc6 apmd || die "newexe failed"

	use nls || rm -rf "${D}"/usr/share/man/fr
}
