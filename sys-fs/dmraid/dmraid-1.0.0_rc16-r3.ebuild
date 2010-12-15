# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dmraid/dmraid-1.0.0_rc16-r3.ebuild,v 1.1 2010/12/15 17:25:09 tommy Exp $

EAPI="2"

inherit autotools linux-info flag-o-matic

MY_PV=${PV/_/.}-3

DESCRIPTION="Device-mapper RAID tool and library"
HOMEPAGE="http://people.redhat.com/~heinzm/sw/dmraid/"
SRC_URI="http://people.redhat.com/~heinzm/sw/dmraid/src/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dietlibc intel_led klibc led mini static"

RDEPEND="|| ( >=sys-fs/lvm2-2.02.45
		sys-fs/device-mapper )
	klibc? ( dev-libs/klibc )
	dietlibc? ( dev-libs/dietlibc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}/${MY_PV}/${PN}

pkg_setup() {
	if kernel_is lt 2 6 ; then
		ewarn "You are using a kernel < 2.6"
		ewarn "DMraid uses recently introduced Device-Mapper features."
		ewarn "These might be unavailable in the kernel you are running now."
	fi
}

src_prepare() {
	epatch	"${FILESDIR}"/${P}-undo-p-rename.patch \
		"${FILESDIR}"/${P}-return-all-sets.patch \
		"${FILESDIR}"/${P}-static-build-fixes.patch
	# pkg_check_modules is not in aclocal.m4 by default, and eautoreconf doesnt add it
	elog "Appending pkg.m4 from system to aclocal.m4"
	cat "${ROOT}"/usr/share/aclocal/pkg.m4 >>"${S}"/aclocal.m4 || die "Could not append pkg.m4"
	eautoreconf

	elog "Creating prepatched source archive for use with Genkernel"
	# archive the patched source for use with genkernel
	cd "${WORKDIR}"
	mkdir -p "tmp/${PN}"
	cp -a "${PN}/${MY_PV}/${PN}" "tmp/${PN}"
	mv "tmp/${PN}/${PN}" "tmp/${PN}/${MY_PV}"
	cd tmp
	tar -jcf ${PN}-${MY_PV}-prepatched.tar.bz2 ${PN} || die
	mv ${PN}-${MY_PV}-prepatched.tar.bz2 ..
}

src_configure() {
	local mylibc
	if use klibc && use dietlibc; then
		ewarn "Cannot compile against both klibc and dietlibc -- choosing klibc."
		mylibc="--enable-klibc --disable-dietlibc"
	else
		mylibc="$(use_enable klibc) $(use_enable dietlibc)"
	fi
	econf --with-usrlibdir='${prefix}'/$(get_libdir) \
		$(use_enable static static_link) \
		$(use_enable mini) \
		$(use_enable led) \
		$(use_enable intel_led) \
		${mylibc}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG README TODO KNOWN_BUGS doc/* || die "dodoc failed"
	insinto /usr/share/${PN}
	doins "${WORKDIR}"/${PN}-${MY_PV}-prepatched.tar.bz2 || die
}

pkg_postinst() {
	elog "For booting Gentoo from Device-Mapper RAID you can use Genkernel."
	elog " "
	elog "Genkernel will generate the kernel and the initrd with a statically "
	elog "linked dmraid binary (its own version which may not be the same as this version):"
	elog "\t emerge -av sys-kernel/genkernel"
	elog "\t genkernel --dmraid all"
	elog " "
	elog "If you would rather use this version of DMRAID with Genkernel, update the following"
	elog "in /etc/genkernel.conf:"
	elog "\t DMRAID_VER=\"${MY_PV}\""
	elog "\t DMRAID_SRCTAR=\"/usr/share/${PN}/${PN}-${MY_PV}-prepatched.tar.bz2\""
	elog " "
	ewarn "DMRAID should be safe to use, but no warranties can be given"
}
