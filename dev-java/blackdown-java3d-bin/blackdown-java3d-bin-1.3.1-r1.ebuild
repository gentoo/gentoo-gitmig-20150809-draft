# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-java3d-bin/blackdown-java3d-bin-1.3.1-r1.ebuild,v 1.4 2006/10/16 23:10:58 nichoj Exp $

inherit java-pkg

DESCRIPTION="Java 3D Software Development Kit"
SRC_URI="x86? ( mirror://blackdown.org/java3d/1.3.1/i386/fcs/java3d-sdk-${PV}-linux-i386.bin )
	amd64? ( mirror://blackdown.org/java3d/1.3.1/amd64/fcs/java3d-sdk-${PV}-linux-amd64.bin )"
HOMEPAGE="http://www.blackdown.org"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* ~amd64 x86"
SLOT="0"
DEPEND=">=virtual/jdk-1.4.1
	>=dev-java/java-config-1.2.6"
RDEPEND=">=virtual/jre-1.4"
IUSE="doc"

S=${WORKDIR}

# Extract the 'skip' value (offset of tarball) we should pass to tail
get_offset() {
	[ ! -f "$1" ] && return

	local offset="`gawk '
		/^[[:space:]]*skip[[:space:]]*=/ {

			sub(/^[[:space:]]*skip[[:space:]]*=/, "")
			SKIP = $0
		}

		END { print SKIP }
	' $1`"

	eval echo $offset
}

src_unpack () {
	local offset="`get_offset ${DISTDIR}/${A}`"

	if [ -z "${offset}" ] ; then
		eerror "Failed to get offset of tarball!" && die
	fi

	einfo "Unpacking ${A}..."
	tail -n +${offset} ${DISTDIR}/${A} | tar --no-same-owner -jxp
}


src_install() {
	dodoc README-Java3D

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r demo /usr/share/doc/${PF}
	fi

	java-pkg_dojar jre/lib/ext/*.jar
	use x86 && arch="i386"
	use amd64 && arch="amd64"

	cd jre/lib/${arch}/
	java-pkg_sointo /opt/${PN}/lib/
	java-pkg_doso *.so
}

pkg_postinst() {
	einfo "This ebuild now installs into /opt/${PN} and /usr/share/${PN}"
	einfo 'To use you need to pass the following to java'
	einfo "-Djava.library.path=\$(java-config -i ${PN}) -cp \$(java-config -p ${PN})"
}
