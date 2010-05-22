# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-opengl/ruby-opengl-0.60.1.ebuild,v 1.6 2010/05/22 15:51:23 flameeyes Exp $

inherit gems

DESCRIPTION="OpenGL / GLUT bindings for ruby"
HOMEPAGE="http://ruby-opengl.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

USE_RUBY="ruby18"

IUSE=""
DEPEND=">=dev-ruby/mkrf-0.2.3
	>=dev-ruby/rake-0.7.3
	virtual/opengl
	virtual/glut"
