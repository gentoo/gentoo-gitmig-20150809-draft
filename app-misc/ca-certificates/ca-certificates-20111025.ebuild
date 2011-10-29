# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ca-certificates/ca-certificates-20111025.ebuild,v 1.1 2011/10/29 21:46:35 robbat2 Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="http://packages.debian.org/sid/ca-certificates"
#NMU_PR="1"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}${NMU_PR:++nmu}${NMU_PR}_all.deb"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

# platforms like AIX don't have a good ar
DEPEND="kernel_AIX? ( app-arch/deb2targz )"
# openssl: we run `c_rehash`
# debianutils: we run `run-parts`
RDEPEND="${DEPEND}
	dev-libs/openssl
	sys-apps/debianutils"

S=${WORKDIR}

pkg_setup() {
	# For the conversion to having it in CONFIG_PROTECT_MASK,
	# we need to tell users about it once manually first.
	[[ -f "${EPREFIX}"/etc/env.d/98ca-certificates ]] \
		|| ewarn "You should run update-ca-certificates manually after etc-update"
}

src_unpack() {
	if [[ -n ${EPREFIX} ]] ; then
		# need to perform everything in the offset, #381937
		mkdir -p "./${EPREFIX}"
		cd "./${EPREFIX}" || die
	fi
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_prepare() {
	cd "./${EPREFIX}" || die
	epatch "${FILESDIR}"/${PN}-20110502-root.patch
	local relp=$(echo "${EPREFIX}" | sed -e 's:[^/]\+:..:g')
	sed -i \
		-e '/="$ROOT/s:ROOT/:ROOT'"${EPREFIX}"'/:' \
		-e '/RELPATH="\.\./s:"$:'"${relp}"'":' \
		usr/sbin/update-ca-certificates || die
}

src_compile() {
	(
	echo "# Automatically generated by ${CATEGORY}/${PF}"
	echo "# $(date -u)"
	echo "# Do not edit."
	cd "${S}${EPREFIX}"/usr/share/ca-certificates
	find * -name '*.crt' | LC_ALL=C sort
	) > "${S}${EPREFIX}"/etc/ca-certificates.conf

	sh "${S}${EPREFIX}"/usr/sbin/update-ca-certificates --root "${S}" || die
}

src_install() {
	cp -pPR * "${D}"/ || die

	mv "${ED}"/usr/share/doc/{ca-certificates,${PF}} || die
	prepalldocs

	echo 'CONFIG_PROTECT_MASK="/etc/ca-certificates.conf"' > 98ca-certificates
	doenvd 98ca-certificates
}

pkg_postinst() {
	if [ -d "${EROOT}/usr/local/share/ca-certificates" ] ; then
		# if the user has local certs, we need to rebuild again
		# to include their stuff in the db.
		# However it's too overzealous when the user has custom certs in place.
		# --fresh is to clean up dangling symlinks
		"${EROOT}"/usr/sbin/update-ca-certificates --root "${EROOT}"
	fi

	local c badcerts=0
	for c in $(find -L "${EROOT}"etc/ssl/certs/ -type l) ; do
		ewarn "Broken symlink for a certificate at $c"
		badcerts=1
	done
	if [ $badcerts -eq 1 ]; then
		ewarn "You MUST remove the above broken symlinks"
		ewarn "Otherwise any SSL validation that use the directory may fail!"
		ewarn "To batch-remove them, run:"
		ewarn "find -L ${EROOT}etc/ssl/certs/ -type l -exec rm {} +"
	fi
}
