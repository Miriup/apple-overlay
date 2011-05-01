# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm bfin cris hppa m68k mips ia64 ppc ppc64 s390 sh sparc x86"

inherit kernel-2
detect_version

DESCRIPTION="The bare minimum of kernel headers for a compiling binutils."
HOMEPAGE=""
SRC_URI="http://opensource.apple.com/tarballs/xnu/xnu-${PV}.tar.gz"

LICENSE="APPLE_LICENSE"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/xnu-${PV}

src_unpack() {
	unpack ${A}
}

src_install() {
	local ddir=$(kernel_header_destdir)

	dodir ${ddir}
	cp -r osfmk/* ${ED}/${ddir}/
	find ${ED}/${ddir}/ -type f ! -name '*.h' | xargs rm
}
