# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.2.2.017.ebuild,v 1.2 2004/07/23 16:07:40 squinky86 Exp $

IUSE="doc mozilla X"

inherit java

At="jdk-1_2_2_017-linux-i586.tar.gz"
S="${WORKDIR}/jdk1.2.2"
SRC_URI="${At}"
DESCRIPTION="Sun Java Development"
HOMEPAGE="http://java.sun.com/products/archive/"
PROVIDE="virtual/jre-1.2.2
	virtual/jdk-1.2.2
	virtual/java-scheme-2"
LICENSE="sun-bcla-java-vm-1.2"
SLOT="1.2"
KEYWORDS="~x86 -ppc -sparc -alpha -mips -hppa -arm"
RESTRICT="fetch"

# NOTE:  Sun's JDK also requires the XFree86 be installed to use the graphical
# libraries.  Even some non-graphical libraries (such as JavaMail) have bizarre
# dependencies on windowing toolkits.
DEPEND="virtual/libc
	>=dev-java/java-config-0.2.7
	doc? ( =dev-java/java-sdk-docs-1.2.2* )"
RDEPEND="sys-libs/lib-compat"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=7740-j2sdk-1.2.2_017-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${DOWNLOAD_URL}
	einfo "(Java(TM) 2 SDK, Standard Edition 1.2.2_017, Linux Platform)"
	einfo "and move it to ${DISTDIR}"
}

pkg_setup() {
	# Issue a warning that this product has been marked as End-of-Life.
	ewarn "BEWARE"
	ewarn "Sun's JDK 1.2.2 has completed the Sun End of Life (EOL) process."
	ewarn "This version is no longer supported by Sun"
	ewarn "Sun is advising users to move to more recent JDK versions."
	echo
	ewarn "Currently this works fine with the x86 glibc version, but break"
	ewarn "with the ~x86 versions, there is bug open on the compatibility"
	ewarn "issue, so i'm hoping it will still work on upcoming versions of"
	ewarn "x86 glibc, so be warned if it doesn't work"
	echo
}

src_install () {
	# Make the root directory for the installation.
	dodir /opt/${P}

	# Copy each of the directories over.
	local dirs="bin include include-old jre lib"
	for i in $dirs ; do
		cp -dPR $i ${D}/opt/${P}/
	done

	# Copy the documentation to Gentoo's documentation directory.
	dodoc CHANGES COPYRIGHT README LICENSE
	dohtml README.html

	# Copy the demo and the source jar to a share directory
	dodir /opt/${P}/share/
	cp -dPR demo src.jar ${D}/opt/${P}/share/

	# Symlink to maintain the directory structure
	dosym /opt/${P}/share/demo /opt/${P}
	dosym /opt/${P}/share/src.jar /opt/${P}

	# From Mozilla's release notes for 1.x:
	# "Java J2SE releases previous to 1.3.0_01 will not work with Mozilla"
	# In Mozilla 1.2.x and higher, they go on to strongly recommend JDK 1.4.x
	# only.

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst

	# Again, this will not work as a Mozilla plugin.
	if use mozilla ; then
		einfo "JDK 1.2.2 does not work with Mozilla.  A more recent JDK is"
		einfo "required."
		echo
	fi

	# Warn the user if they don't appear to have XFree86 installed.
	if ! use X ; then
		ewarn "Some parts of Sun's JDK require XFree86 to be installed."
		ewarn "Be careful which Java libraries you attempt to use."
		echo
	fi
}
