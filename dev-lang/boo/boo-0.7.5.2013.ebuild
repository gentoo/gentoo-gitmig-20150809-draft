# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/boo/boo-0.7.5.2013.ebuild,v 1.2 2006/01/19 05:40:36 latexer Exp $

inherit mono fdo-mime eutils

DESCRIPTION="A wrist friendly language for the CLI"
HOMEPAGE="http://boo.codehaus.org/"

SRC_URI="http://dist.codehaus.org/boo/distributions/${P}-src.tar.bz2"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1.4
		dev-dotnet/nant
		x11-misc/shared-mime-info
		>=x11-libs/gtksourceview-1.0.1"

src_unpack() {
	if has_version "dev-lang/boo"; then
		if ! has_version "=dev-lang/boo-${PV}"; then
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
	LC_ALL="C" LANG="C" nant -t:mono-1.0 -D:install.prefix=/usr || die
}

src_install() {
	LC_ALL="C" LANG="C" nant install \
		-D:install.destdir=${D} -t:mono-1.0 -D:install.prefix=/usr || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
