# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/schroot/schroot-1.4.1-r1.ebuild,v 1.1 2010/03/26 18:14:15 abcd Exp $

EAPI="2"
WANT_AUTOMAKE="1.11"

inherit autotools base pam

DESCRIPTION="Utility to execute commands in a chroot environment"
HOMEPAGE="http://packages.debian.org/source/sid/schroot"
SRC_URI="mirror://debian/pool/main/${PN::1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dchroot debug doc lvm nls pam test"

COMMON_DEPEND="
	>=dev-libs/boost-1.42.0
	dev-libs/lockdev
	>=sys-apps/util-linux-2.16
	lvm? ( sys-fs/lvm2 )
	pam? ( sys-libs/pam )
"

DEPEND="${COMMON_DEPEND}
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)
	nls? ( sys-devel/gettext )
	test? ( >=dev-util/cppunit-1.10.0 )
"
RDEPEND="${COMMON_DEPEND}
	sys-apps/debianutils
	dchroot? ( !sys-apps/dchroot )
	nls? ( virtual/libintl )
"

PATCHES=(
	"${FILESDIR}/${PN}-1.4.0-tests.patch"
	# This patch requires boost >= 1.42.0
	"${FILESDIR}/${PN}-1.4.1-boost-validation_error.patch"
)

src_prepare() {
	base_src_prepare

	# Don't depend on cppunit unless we are testing
	use test || sed -i '/AM_PATH_CPPUNIT/d' configure.ac

	echo -e "Package: ${PN}\nVersion: ${PV}" > VERSION

	eautoreconf
}

src_configure() {
	root_tests=no
	use test && (( EUID == 0 )) && root_tests=yes
	econf \
		$(use_enable doc doxygen) \
		$(use_enable dchroot) \
		$(use_enable dchroot dchroot-dsa) \
		$(use_enable debug) \
		$(use_enable lvm lvm-snapshot) \
		$(use_enable nls) \
		$(use_enable pam) \
		--enable-block-device \
		--enable-loopback \
		--enable-uuid \
		--enable-root-tests=$root_tests \
		--enable-shared \
		--disable-static \
		--localstatedir=/var \
		--with-bash-completion-dir=/usr/share/bash-completion
}

src_test() {
	if [[ $root_tests == yes && $EUID -ne 0 ]]; then
		ewarn "Disabling tests because you are no longer root"
		return 0
	fi
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/schroot.initd schroot || die "installation of init.d script failed"
	newconfd "${FILESDIR}"/schroot.confd schroot || die "installation of conf.d file failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "installation of docs failed"
	if use doc; then
		docinto html/sbuild
		dohtml doc/sbuild/html/* || die "installation of html docs failed"
		docinto html/schroot
		dohtml doc/schroot/html/* || die "installation of html docs failed"
	fi

	if use pam; then
		rm -f "${D}"/etc/pam.d/schroot
		pamd_mimic_system schroot auth account session
	fi

	# Remove *.la files
	find "${D}" -name "*.la" -exec rm {} + || die "removal of *.la files failed"
}

pkg_preinst() {
	export had_older_1_4_1=false
	has_version "<dev-util/schroot-1.4.1" && had_older_1_4_1=true
	if ${had_older_1_4_1}; then
		einfo "Moving config files to new location..."
		mkdir "${ROOT}etc/schroot/default"
		mv_conffile etc/schroot/script-defaults etc/schroot/default/config
		mv_conffile etc/schroot/mount-defaults etc/schroot/default/fstab
		mv_conffile etc/schroot/copyfiles-defaults etc/schroot/default/copyfiles
		mv_conffile etc/schroot/nssdatabases-defaults etc/schroot/default/nssdatabases
	fi
}

mv_conffile() {
	local OLDFILE=${ROOT}$1
	local NEWFILE=${ROOT}$2

	# if the old file doesn't exist, or is a symlink, stop
	[[ -f ${OLDFILE} ]] || return 0
	[[ -L ${OLDFILE} ]] && return 0

	# if the new file already exists, then we have a problem...
	if [[ -e ${NEWFILE} ]]; then
		# but if they are the same, then don't worry about it
		if cmp -s "${OLDFILE}" "${NEWFILE}"; then
			rm -f "${OLDFILE}"
		else
			ewarn "${NEWFILE} already exists, not moving ${OLDFILE}"
		fi
	else
		mv "${OLDFILE}" "${NEWFILE}"
	fi

	local x y
	# now move all the unmerged config files as well
	for x in "${OLDFILE%/*}"/._cfg????_"${OLDFILE##*/}"; do
		[[ -f ${x} ]] || continue
		# /etc/schroot/._cfg0000_script-defaults -> /etc/schroot/default/._cfg0000_config
		y=${x##*/}
		y=${NEWFILE%*/}${y%${OLDFILE##*/}}${NEWFILE##*/}
		mv "${x}" "${y}"
	done
}

pkg_postinst() {
	local x
	if ${had_older_1_4_1}; then
		for x in script:config mount:fstab copyfiles nssdatabases; do
			if [[ ! -e ${ROOT}etc/schroot/${x%:*}-defaults && -f ${ROOT}etc/schroot/default/${x#*:} ]]; then
				einfo "Creating compatibility symlink for ${x%:*}-defaults"
				ln -sf "default/${x#*:}" "${ROOT}etc/schroot/${x%:*}-defaults"
			fi
		done

		ewarn "Your config files have been moved to the new location in"
		ewarn "/etc/schroot/default. Compatibility symlinks have been installed in"
		ewarn "/etc/schroot, and may be removed if no running chroot refers to them."
	fi
}
