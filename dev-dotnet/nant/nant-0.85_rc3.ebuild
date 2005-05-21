# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nant/nant-0.85_rc3.ebuild,v 1.3 2005/05/21 09:18:24 slarti Exp $

inherit mono eutils

MY_P=${P/_rc/-rc}

DESCRIPTION=".NET build tool"
HOMEPAGE="http://nant.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-lang/mono-1.1.4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	local targetlibdir=""
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.85-rc2-is-unix.diff || die
	epatch ${FILESDIR}/${PN}-0.85-rc2-profile.diff || die
	epatch ${FILESDIR}/${MY_P}-mono-1.1.7-compat.diff || die

	# Fix a problem with duplicate building caused by the doc= target
	for file in $(find ${S}/src -name '*.build')
	do
		sed -i "s: doc=.*>:>:" \
			${file}
	done

	# Problem with is-unix() on mono-1.1.x where the platform is detected
	# as !is-unix().
	sed -i -e "s:install-windows, install-linux:install-linux:" \
		-e 's:if.*is-unix()}\"::' \
		${S}/NAnt.build || die "sed failed"

	# When we have mono-1.1.x, we should build against 2.0,
	# so that people using nant can use either the 2.0 or 1.0 profiles
	if has_version ">=dev-lang/mono-1.1.4"; then
		sed -i -e "s/-f:NAnt.build/-t:mono-2.0 -f:NAnt.build/" \
			${S}/Makefile || die "sed failed"

		targetlibdir="${S}/build/mono-2.0.unix/nant-0.85-debug/bin/lib/"
	else
		# Fix for AppDomain unloading on 1.0.x. See bug #90113
		export MONO_NO_UNLOAD=1
		targetlibdir="${S}/build/mono-1.0.unix/nant-0.85-debug/bin/lib/"
	fi

	# Fix for build problem with rc3
	mkdir -p "${targetlibdir}"
	cp ${S}/lib/log4net.dll "${targetlibdir}"
}

src_compile() {
	emake -j1 || die
}

src_install() {
	make prefix=${D}/usr install || die
	# Fix ${D} showing up in the nant wrapper script, as well as silencing
	# warnings related to the log4net library
	sed -i \
		-e "s:${D}::" \
		-e "2iexport MONO_SILENT_WARNING=1" \
		${D}/usr/bin/nant
	dodoc README.txt

	# Remove the extraneous log4net.dll copy
	rm ${D}/usr/share/NAnt/bin/lib/log4net.dll
}
