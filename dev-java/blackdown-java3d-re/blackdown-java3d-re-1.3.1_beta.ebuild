# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-java3d-re/blackdown-java3d-re-1.3.1_beta.ebuild,v 1.1 2004/02/21 04:32:37 zx Exp $

DESCRIPTION="Java 3D Runtime Environment ${PV}"
SRC_URI="mirror://blackdown.org/java3d/1.3.1/i386/beta/java3d-re-${PV/_beta/-beta}-linux-i386.bin"
HOMEPAGE="http://www.blackdown.org"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
SLOT="0"
DEPEND=">=virtual/jre-1.4.1"

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
	dodir `java-config -O`/jre
	cp -a lib ${D}/`java-config -O`/jre/
}

pkg_postinst() {
	einfo "Note: This package installs into your currently selected JDK!"
	einfo "Your currently selected JDK path is:"
	einfo "\t `java-config -O`"
	einfo 
	einfo "If this is incorrect, please unmerge this package and set your desired"
	einfo "JDK with java-config"
}
