# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/quilt/quilt-0.37.ebuild,v 1.1 2005/03/09 09:44:05 ferringb Exp $

inherit bash-completion eutils

DESCRIPTION="quilt patch manager"
HOMEPAGE="http://savannah.nongnu.org/projects/quilt"
#SRC_URI="http://savannah.nongnu.org/download/quilt/${P}.tar.gz"
# There are packages hosted at the savannah site, but the maintainers do not
# update them.  Which means we either have to hit the deb package or the suse
# RPM for a current version.
# yuck.
SRC_URI="mirror://debian/pool/main/q/quilt/${P//-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="sys-devel/patch
	>=sys-apps/sed-4
	app-arch/bzip2
	app-arch/gzip
	dev-util/diffstat
	sys-apps/gawk
	sys-apps/sed
	dev-lang/perl"

src_install() {
	make BUILD_ROOT="${D}" install || die
	# Remove the installed doc dir, as it not only contains uncompressed
	# files but it also breaks policy by being named ${P} instead of ${PF}.
	rm -rf ${D}/usr/share/doc/${P}
	dodoc AUTHORS BUGS quilt.changes doc/README doc/quilt.pdf \
		doc/sample.quiltrc


	# Install the bash completion file in the usual Gentoo way, so users
	# can decide whether it should be enabled or not.
	rm ${D}/etc/bash_completion.d/quilt
	dobashcompletion bash_completion ${PN}
}

pkg_postinst() {
	bash-completion_pkg_postinst
}
