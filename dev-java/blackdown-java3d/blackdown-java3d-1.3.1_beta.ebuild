# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-java3d/blackdown-java3d-1.3.1_beta.ebuild,v 1.1 2004/02/21 04:59:40 zx Exp $

DESCRIPTION="Java 3D Software Development Kit"
SRC_URI="mirror://blackdown.org/java3d/1.3.1/i386/beta/java3d-sdk-${PV/_beta/-beta}-linux-i386.bin"
HOMEPAGE="http://www.blackdown.org"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~sparc ~amd64"
SLOT="0"
DEPEND=">=virtual/jre-1.4.1"
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


src_install () {
	dodoc README-Java3D

	dodir `java-config -o`/jre
	cp -a jre/lib ${D}/`java-config -o`/jre
	use doc && cp -a demo ${D}/`java-config -o`/demo
}

pkg_postinst() {
	einfo "Note: This package installs into your currently selected JRE!"
	einfo "Your currently selected JRE path is:"
	einfo "\t `java-config -o`"
	einfo
	einfo "If this is incorrect, please unmerge this package and set your desired"
	einfo "JRE with java-config"
}
