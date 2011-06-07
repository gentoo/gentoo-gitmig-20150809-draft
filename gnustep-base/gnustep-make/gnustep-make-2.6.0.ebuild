# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/gnustep-make-2.6.0.ebuild,v 1.4 2011/06/07 13:48:56 voyageur Exp $

EAPI="3"

inherit gnustep-base eutils prefix

DESCRIPTION="GNUstep Makefile Package"

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="native-exceptions"
SLOT="0"
LICENSE="GPL-2"

DEPEND="${GNUSTEP_CORE_DEPEND}
	>=sys-devel/gcc-3.3[objc]
	>=sys-devel/make-3.75
	!gnustep-base/libobjc2"
RDEPEND="${DEPEND}"

src_prepare() {
	# Multilib-strict
	sed -e "s#/lib#/$(get_libdir)#" -i FilesystemLayouts/fhs-system || die "sed failed"
	epatch "${FILESDIR}"/${PN}-2.0.1-destdir.patch
	cp "${FILESDIR}"/gnustep-4.{csh,sh} "${T}"/
	eprefixify "${T}"/gnustep-4.{csh,sh}
}

src_configure() {
	econf \
		--with-layout=fhs-system \
		--with-config-file="${EPREFIX}"/etc/GNUstep/GNUstep.conf \
		$(use_enable native-exceptions native-objc-exceptions) \
		|| die "configure failed"
}

src_compile() {
	emake || die "compilation failed"
	# Prepare doc here (needed when no gnustep-make is already installed)
	if use doc ; then
		# If a gnustep-1 environment is set
		unset GNUSTEP_MAKEFILES
		pushd Documentation &> /dev/null
		emake all install || die "doc make has failed"
		popd &> /dev/null
	fi
}

src_install() {
	# Get GNUSTEP_* variables
	. ./GNUstep.conf

	local make_eval
	use debug || make_eval="${make_eval} debug=no"
	make_eval="${make_eval} verbose=yes"

	emake ${make_eval} DESTDIR="${D}" install || die "install has failed"

	# Copy the documentation
	if use doc ; then
		dodir ${GNUSTEP_SYSTEM_LIBRARY}
		cp -r Documentation/tmp-installation/System/Library/Documentation \
			"${ED}"${GNUSTEP_SYSTEM_LIBRARY}
	fi

	dodoc FAQ README RELEASENOTES

	exeinto /etc/profile.d
	doexe "${T}"/gnustep-4.sh
	doexe "${T}"/gnustep-4.csh
}

pkg_postinst() {
	# Warn about new layout if old GNUstep directory is still here
	if [ -e /usr/GNUstep/System ]; then
		ewarn "Old layout directory detected (/usr/GNUstep/System)"
		ewarn "Gentoo has switched to FHS layout for GNUstep packages"
		ewarn "You must first update the configuration files from this package,"
		ewarn "then remerge all packages still installed with the old layout"
		ewarn "You can use gnustep-base/gnustep-updater for this task"
	fi
}
