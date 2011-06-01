# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/symon/symon-2.83.ebuild,v 1.1 2011/06/01 02:44:21 jer Exp $

EAPI="1"

inherit perl-module toolchain-funcs

DESCRIPTION="Performance and information monitoring tool"
HOMEPAGE="http://www.xs4all.nl/~wpd/symon/"
SRC_URI="http://www.xs4all.nl/~wpd/symon/philes/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="perl +symon symux"

RDEPEND="perl? ( dev-lang/perl )
	symux? ( net-analyzer/rrdtool )"
DEPEND="${RDEPEND}
	virtual/pmake"

S=${WORKDIR}/${PN}

# Deletes the directory passed as an argument from the internal pmake
# variable SUBDIR.
zap_subdir() {
	sed -i "/^SUBDIR/s/$1//" Makefile || die "sed $1 failed"
}

pkg_setup() {
	use symon && USE_SYMON=1 && return

	if ! use perl && ! use symon && ! use symux; then
		ewarn "You have all available USE flags disabled. Therefore, only the"
		ewarn "system monitor will be emerged. Please, enable at least one USE"
		ewarn "flag to avoid this message."
		USE_SYMON=1
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Respect LDFLAGS.
	sed -i "/^[ \t]*\${CC}.*\${LIBS}/s/\${CC}/& \${LDFLAGS}/" sym*/Makefile \
		|| die "sed ldflags failed"

	# Do some sed magic in accordance with the USE flags.
	use perl && [[ -z ${USE_SYMON} ]] && ! use symux && zap_subdir lib
	! use perl && zap_subdir client
	! use symux && zap_subdir symux
	[[ -z ${USE_SYMON} ]] && zap_subdir symon
}

src_compile() {
	pmake CC="$(tc-getCC)" CFLAGS+="${CFLAGS}" STRIP=true || die "pmake failed"
}

src_install() {
	if [[ -n ${USE_SYMON} ]]; then
		insinto /etc
		doins "${FILESDIR}"/symon.conf || die "doins symon.conf failed"

		newinitd "${FILESDIR}"/symon-init.d symon || die "newinitd symon failed"

		dodoc CHANGELOG HACKERS TODO || die "dodoc failed"

		doman symon/symon.8 || die "doman symon failed"
		dosbin symon/symon || die "dosbin symon failed"
	fi

	if use perl; then
		dobin client/getsymonitem.pl || die "dobin getsymonitem.pl failed"

		perlinfo
		insinto ${VENDOR_LIB}
		doins client/SymuxClient.pm || die "doins SymuxClient.pm failed"
	fi

	if use symux; then
		insinto /etc
		doins "${FILESDIR}"/symux.conf || die "doins symux.conf failed"

		newinitd "${FILESDIR}"/symux-init.d symux || die "newinitd symux failed"

		doman symux/symux.8 || die "doman symux failed"
		dosbin symux/symux || die "dosbin symux failed"

		dodir /usr/share/symon
		insinto /usr/share/symon
		doins symux/c_smrrds.sh || die "doins c_smrrds.sh failed"
		fperms a+x /usr/share/symon/c_smrrds.sh

		dodir /var/lib/symon/rrds/localhost
	fi
}

pkg_postinst() {
	use perl && perl-module_pkg_postinst

	if use symux; then
		elog "The RRDs files can be obtained by running"
		elog "/usr/share/symon/c_smrrds.sh all."
		elog "For information about migrating RRDs from a previous"
		elog "symux version read the LEGACY FORMATS section of symux(8)."
		elog "To view the rrdtool pictures of the stored data, emerge"
		elog "net-analyzer/syweb."
	fi
}
