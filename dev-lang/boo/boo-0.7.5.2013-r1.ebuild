# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/boo/boo-0.7.5.2013-r1.ebuild,v 1.2 2007/06/28 01:28:08 jurek Exp $

inherit mono fdo-mime eutils

DESCRIPTION="A wrist friendly language for the CLI"
HOMEPAGE="http://boo.codehaus.org/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/archive/${P}-src.tar.bz2"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

DEPEND=">=dev-lang/mono-1.1.4
		dev-dotnet/nant
		x11-misc/shared-mime-info
		>=x11-libs/gtksourceview-1.0.1"

src_unpack() {
	if has_version "dev-lang/boo"; then
		if ! (has_version ">=dev-lang/boo-${PV}" &&
			has_version	 "<=dev-lang/boo-${PVR}"); then
			eerror "This version of boo has a problem compiling when any other"
			eerror "version of boo is present on the system. Please unmerge boo"
			eerror "and then try emerging this version of boo. See bug #108520"
			eerror "at https://bugs.gentoo.org/show_bug.cgi?id=108520 for more"
			eerror "details."
			die "Version of boo installed will cause compilation errors."
		fi
	fi

	unpack ${A}
	cd ${S}
}

src_compile() {
	# We no longer need to provide boo.lang (bug #163926)
	sed -i -e 's#^.*<copy file="extras/boo.lang".*$##' \
		default.build || die "sed failed"

	nant -t:mono-1.0 -D:install.prefix=/usr || die "build failed"
}

src_install() {
	nant install \
		-D:install.destdir=${D} -t:mono-1.0 -D:install.prefix=/usr ||
		die "install failed"

	use doc && dodoc docs/BooManifesto.sxw

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
