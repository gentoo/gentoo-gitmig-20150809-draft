# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-java3d/blackdown-java3d-1.3.1.ebuild,v 1.2 2004/04/04 04:46:29 zx Exp $

DESCRIPTION="Java 3D Software Development Kit"
SRC_URI="mirror://blackdown.org/java3d/1.3.1/i386/fcs/java3d-sdk-${PV}-linux-i386.bin"
HOMEPAGE="http://www.blackdown.org"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~sparc ~amd64"
SLOT="0"
DEPEND=">=virtual/jdk-1.4.1"
RDEPEND=">=dev-java/java-config-1.2.6"
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

	dodir `java-config -O`/jre
	cp -a jre/lib ${D}/`java-config -O`/jre
	use doc && cp -a demo ${D}/`java-config -O`/demo
}

pkg_postinst() {
	einfo "Note: This package installs into your currently selected JDK!"
	einfo "Your currently selected JDK path is:"
	einfo "\t `java-config -O`"
	einfo
	einfo "If this is incorrect, please unmerge this package and set your desired"
	einfo "JDK with java-config"
}
